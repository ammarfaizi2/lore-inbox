Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311723AbSCXHRr>; Sun, 24 Mar 2002 02:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311731AbSCXHRi>; Sun, 24 Mar 2002 02:17:38 -0500
Received: from ohiper1-13.apex.net ([209.250.47.28]:21765 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S311723AbSCXHRc>; Sun, 24 Mar 2002 02:17:32 -0500
Date: Sun, 24 Mar 2002 01:16:04 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Andre Pang <ozone@algorithm.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Screen corruption in 2.4.18
Message-ID: <20020324071604.GA15618@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <200203222204.XAA01121@jagor.srce.hr> <20020322232304.GA19579@hapablap.dyn.dhs.org> <200203231526.QAA09302@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 01:13:49 up 3 days, 11 min,  0 users,  load average: 1.25, 1.05, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 06:05:16PM +1100, Andre Pang wrote:
> On Sat, Mar 23, 2002 at 10:06:47AM -0600, Steven Walter wrote:
> 
> > > Don't get it wrong. I *do have* an VT8365. VT8365 (ProSavage KM133) is 
> > > somewhat the same as VT8363 (KT133), except that 8365 has an integrated 
> > > Savage graphics card (which *I use*).
> > 
> > Aha... I see.  And in thinking about it, I realize that my motherboard
> > also has this integrated graphics card.  Perhaps this is the difference?
> > Unfortunately, it seems they both report the same PCI id, so I don't
> > really know of a way to differentiate them.
> 
> I can verify Danijel's report -- I have the same setup
> (VT8363+VT8353, a.k.a. ProSavage KM133), and I experience the
> same screen corruption.  Clearing only bit 7 of register 55 fixes
> the problem; clearing bits 5 and 6 causes the video to go all
> borky.  There's been another thread about it on lkml over the
> last week or so.
> 
> > I looked at that datasheet, and the datasheet for the 8363.  Both said
> > not to program offset 55, and both said the bits we are clearing are
> > "reserved."  Perhaps we should contact VIA directly, tell them the
> > problem we're having with their current fix, tell them our theory, and
> > ask if we're right.
> 
> Heh, a VIA contact who knows what the hell that register does
> would be nice :).
> 
> In the meantime, I'd probably suggest a patch which looks for
> clears only bit 7 of Rx55 if an 8363 and an 8365 is found.  I'll
> whip one up later today.

Alright.  Two seperate verifications are enough for me.  I have a patch,
but had been sitting on it for the time.  But, here it is.  Comments are
welcome, I'd like to see this included in 2.4.x and 2.5.x

Thanks
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

--- pci-pc.c~	Sat Mar 23 15:01:37 2002
+++ pci-pc.c	Sat Mar 23 15:03:45 2002
@@ -1197,16 +1197,19 @@
 {
 	u8 v;
 	int where = 0x55;
+	int mask = 0x7f; /* Don't clear bits 5 and 6 on the KT133!  It
+			  * causes strange screen corruption... */
 
 	if (d->device == PCI_DEVICE_ID_VIA_8367_0) {
 		where = 0x95; /* the memory write queue timer register is 
 				 different for the kt266x's: 0x95 not 0x55 */
+		mask = 0x1f; /* clear bits 5, 6, 7 */
 	}
 
 	pci_read_config_byte(d, where, &v);
 	if (v & 0xe0) {
-		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n", where, v, v & 0x1f);
-		v &= 0x1f; /* clear bits 5, 6, 7 */
+		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n", where, v, v & mask);
+		v &= mask;
 		pci_write_config_byte(d, where, v);
 	}
 }
