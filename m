Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCKPpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUCKPpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:45:45 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:55526 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261430AbUCKPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:45:09 -0500
Date: Thu, 11 Mar 2004 12:43:31 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-ID: <20040311154331.GA1755@conectiva.com.br>
References: <20040305174049.GA1759@conectiva.com.br> <20040305150615.0ae07114.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040305150615.0ae07114.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.493673, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 05, 2004 at 03:06:15PM -0800, Andrew Morton wrote:
> Flavio Bruno Leitner <fbl@conectiva.com.br> wrote:
> >
> > My laptop is an Acer TravelMate 630 and somewhere between 2.6.2 and 2.6.3-rc2 
> > begins returning an oops right after boot.
> > 
> > kernel BUG at kernel/timer.c:370!
> 
> Oh fantastic.  Something scrogged the timer lists.
> 
> I suggest you try stripping your kernel config down the the bare minimum
> which is needed to boot, see if that fixes it and if so, start
> reintroducing things until you've worked out which driver is causing the
> problem.

Done!

The oops happens when the patch is applied, just do ifconfig eth0 down 
and ifconfig eth0 <with another ip>  up. The dhcp always get wrong ip, 
so my rc.local run ifconfig down and up. Removing the patch, I can't 
reproduce it anymore.

This oops still happens with newer kernels.

Thanks!


-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ifdown-up-oops.patch"

diff -Nru a/include/linux/inetdevice.h b/include/linux/inetdevice.h
--- a/include/linux/inetdevice.h	Fri Apr 11 03:35:44 2003
+++ b/include/linux/inetdevice.h	Thu Jan 29 20:57:46 2004
@@ -21,6 +21,7 @@
 	int	medium_id;
 	int	no_xfrm;
 	int	no_policy;
+	int	force_igmp_version;
 	void	*sysctl;
 };
 
diff -Nru a/net/ipv4/igmp.c b/net/ipv4/igmp.c
--- a/net/ipv4/igmp.c	Sat Jan 24 15:54:51 2004
+++ b/net/ipv4/igmp.c	Mon Feb  2 21:43:31 2004
@@ -126,10 +126,14 @@
  * contradict to specs provided this delay is small enough.
  */
 
-#define IGMP_V1_SEEN(in_dev) ((in_dev)->mr_v1_seen && \
-		time_before(jiffies, (in_dev)->mr_v1_seen))
-#define IGMP_V2_SEEN(in_dev) ((in_dev)->mr_v2_seen && \
-		time_before(jiffies, (in_dev)->mr_v2_seen))
+#define IGMP_V1_SEEN(in_dev) (ipv4_devconf.force_igmp_version == 1 || \
+		(in_dev)->cnf.force_igmp_version == 1 || \
+		((in_dev)->mr_v1_seen && \
+		time_before(jiffies, (in_dev)->mr_v1_seen)))
+#define IGMP_V2_SEEN(in_dev) (ipv4_devconf.force_igmp_version == 2 || \
+		(in_dev)->cnf.force_igmp_version == 2 || \
+		((in_dev)->mr_v2_seen && \
+		time_before(jiffies, (in_dev)->mr_v2_seen)))
 
 static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im);
 static void igmpv3_del_delrec(struct in_device *in_dev, __u32 multiaddr);
@@ -1063,7 +1067,7 @@
 	reporter = im->reporter;
 	igmp_stop_timer(im);
 
-	if (in_dev->dev->flags & IFF_UP) {
+	if (!in_dev->dead) {
 		if (IGMP_V1_SEEN(in_dev))
 			goto done;
 		if (IGMP_V2_SEEN(in_dev)) {
@@ -1094,6 +1098,8 @@
 	if (im->multiaddr == IGMP_ALL_HOSTS)
 		return;
 
+	if (in_dev->dead)
+		return;
 	if (IGMP_V1_SEEN(in_dev) || IGMP_V2_SEEN(in_dev)) {
 		spin_lock_bh(&im->lock);
 		igmp_start_timer(im, IGMP_Initial_Report_Delay);
@@ -1167,7 +1173,7 @@
 	igmpv3_del_delrec(in_dev, im->multiaddr);
 #endif
 	igmp_group_added(im);
-	if (in_dev->dev->flags & IFF_UP)
+	if (!in_dev->dead)
 		ip_rt_multicast_event(in_dev);
 out:
 	return;
@@ -1191,7 +1197,7 @@
 				write_unlock_bh(&in_dev->lock);
 				igmp_group_dropped(i);
 
-				if (in_dev->dev->flags & IFF_UP)
+				if (!in_dev->dead)
 					ip_rt_multicast_event(in_dev);
 
 				ip_ma_put(i);
@@ -1266,6 +1272,9 @@
 	struct ip_mc_list *i;
 
 	ASSERT_RTNL();
+
+	/* Deactivate timers */
+	ip_mc_down(in_dev);
 
 	write_lock_bh(&in_dev->lock);
 	while ((i = in_dev->mc_list) != NULL) {

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"


Hello!

My laptop is an Acer TravelMate 630 and somewhere between 2.6.2 and 2.6.3-rc2 
begins returning an oops right after boot.

kernel BUG at kernel/timer.c:370!
invalid operand: 0000 [#1]
CPU:	0
EIP:	0060:[<c0127177>]	Not tainted
EFLAGS: 00010006
EIP is at cascade+0x44/0x4e
eax: c03e4368	ebx: c03e02b0	ecx: fffce200	edx: c03e03b0
esi: c03e0398	edi: c03dfa80	ebp: c0387f08	esp: c0387ef4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0386000 task=c0306520)
Stack: c03dfa80 cde229c4 00000000 c03df7a8 c0387f20 c0387f38 c0127732 c03dfa80
       c03e0288 00000022 c0387f34 c0387f20 c0387f20 c0308d64 00000001 c03df7a8
       0000000a c0387f54 c0123b7c c03df7a8 00000046 00000000 c037da00 c0308d64
Call Trace:
  [<c0127732>] run_timer_softirq+0xec/0x16b
  [<c0123b7c>] do_softirq+0x98/0x9a
  [<c010d2ff>] do_IRQ+0xe4/0x11c
  [<c010b974>] common_interrupt+0x18/0x20
  [<d08c8257>] acpi_processor_idle+0xe9/0x1e5 [processor]
  [<c0105000>] _stext+0x0/0x2a
  [<c01090b7>] cpu_idle+0x2f/0x38
  [<c038c70a>] start_kernel+0x185/0x1c9
  [<c038c44a>] unknow_bootoption+0x0/0x108

Code: 0f 0b 72 01 3b 05 2d c0 eb d4 55 89 e5 56 53 83 ec 04 0f bf


--rS8CxjVDS/+yyDmU--
