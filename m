Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273479AbRIUMY3>; Fri, 21 Sep 2001 08:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273484AbRIUMYU>; Fri, 21 Sep 2001 08:24:20 -0400
Received: from pD4B9DBE1.dip.t-dialin.net ([212.185.219.225]:44292 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S273479AbRIUMYF> convert rfc822-to-8bit;
	Fri, 21 Sep 2001 08:24:05 -0400
Message-ID: <3BAB314E.5A00944A@baldauf.org>
Date: Fri, 21 Sep 2001 14:23:42 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: "'netfilter@lists.samba.org'" <netfilter@lists.samba.org>
CC: linux-kernel@vger.kernel.org
Subject: ip_conntrack lockups
In-Reply-To: <3B1F711F.315B56EB@baldauf.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I now have additional information regarding this bug.

I have changed my linux kernel (currently 2.4.10-pre4) using
following patch:

--- linux/include/linux/netfilter_ipv4/listhelp.h.orig  Sun
Aug 12 18:29:34 2001
+++ linux/include/linux/netfilter_ipv4/listhelp.h       Tue
Aug 21 20:23:28 2001
@@ -49,15 +49,20 @@
        return LIST_FIND(head, __list_cmp_same, void *,
entry) != NULL;
 }

+extern void show_stack(unsigned long * esp);
+
 /* Delete from list. */
 #ifdef CONFIG_NETFILTER_DEBUG
 #define LIST_DELETE(head,
oldentry)                                    \
 do
{
\

ASSERT_WRITE_LOCK(head);
\
-       if (!list_inlist(head,
oldentry))                               \
+       if (!list_inlist(head, oldentry))
{                       \
+
show_stack(NULL);                                       \
                printk("LIST_DELETE: %s:%u `%s'(%p) not in
%s.\n",      \
-                      __FILE__, __LINE__, #oldentry,
oldentry, #head); \
-        else list_del((struct list_head
*)oldentry);                   \
+               __FILE__, __LINE__, #oldentry, oldentry,
#head);        \
+       } else
{                                                        \
+               list_del((struct list_head
*)oldentry);                 \
+
}
\
 } while(0)
 #else
 #define LIST_DELETE(head, oldentry) list_del((struct
list_head *)oldentry)
--- linux/arch/i386/kernel/i386_ksyms.c.orig    Tue Aug 21
20:31:59 2001
+++ linux/arch/i386/kernel/i386_ksyms.c Tue Aug 21 20:37:54
2001
@@ -161,3 +161,7 @@
 #ifdef CONFIG_X86_PAE
 EXPORT_SYMBOL(empty_zero_page);
 #endif
+
+extern void show_stack(unsigned long * esp);
+
+EXPORT_SYMBOL(show_stack);

This patch makes the macro LIST_DELETE print a stack trace.
Now I encountered this bug again:

dmesg excerpt:

c0263ed8 00000000 c09c75e0 c02965a0 00000000 c09c75e8
c09c7604 c526cc6a
       c09c75e0 c09c75e0 c526cc04 c011b332 c09c75e0 c02a03e0
00000000 c02965a0
       00000000 c0263f7c 20000001 00000000 c0118516 c0118449
00000000 00000001
Call Trace: [<c526cc6a>] [<c526cc04>] [<c011b332>]
[<c0118516>] [<c0118449>]
   [<c011824a>] [<c010805d>] [<c0106c00>] [<c019a238>]
[<c019a22c>] [<c011f8c1>]
   [<c01051d7>] [<c0105000>] [<c0105027>]
LIST_DELETE: ip_conntrack_core.c:165
`&ct->tuplehash[IP_CT_DIR_REPLY]'(c09c7604) not in
&ip_conntrack_hash
[hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].


after running this through ksymoops:

c0263ed8 00000000 c09c75e0 c02965a0 00000000 c09c75e8
c09c7604 c526cc6a
       c09c75e0 c09c75e0 c526cc04 c011b332 c09c75e0 c02a03e0
00000000 c02965a0
       00000000 c0263f7c 20000001 00000000 c0118516 c0118449
00000000 00000001
Call Trace: [<c526cc6a>] [<c526cc04>] [<c011b332>]
[<c0118516>] [<c0118449>]
   [<c011824a>] [<c010805d>] [<c0106c00>] [<c019a238>]
[<c019a22c>] [<c011f8c1>]
   [<c01051d7>] [<c0105000>] [<c0105027>]
Warning (Oops_read): Code line not seen, dumping what data
is available

Trace; c526cc6a <[ip_conntrack]death_by_timeout+66/d8>
Trace; c526cc04 <[ip_conntrack]death_by_timeout+0/d8>
Trace; c011b332 <timer_bh+23e/27c>
Trace; c0118516 <bh_action+1a/48>
Trace; c0118449 <tasklet_hi_action+59/80>
Trace; c011824a <do_softirq+5a/ac>
Trace; c010805d <do_IRQ+9d/b0>
Trace; c0106c00 <ret_from_intr+0/7>
Trace; c019a238 <pr_power_idle+c/1f8>
Trace; c019a22c <pr_power_idle+0/1f8>
Trace; c011f8c1 <check_pgt_cache+11/18>
Trace; c01051d7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Apparrently, death_by_timeout calls clean_from_lists, which
contains the expanded LIST_DELETE macro. Maybe this helps in
determining the reason for the lockup.
Note that the lockup does not occur immediately. It seems
that the lockup happens when my auto-dial-up connection
closes and all netfilter-related modules are automatically
removed by the "ip-down" script using rmmod.

So I guess that there is a race due to inproperly locking or
something like this. Maybe there is a time window where the
conntrack is removed from the lists but its timer function
is not yet deregistered. If, in that time window, the timer
function is called, the bug happens. Is this possible?

Maybe there is a second bug: if a conntrack is not found in
the lists anymore, this should not be such a problem. But
why does the machine lockup at module unload? Is this an
endless loop? What can cause such an endless loop?

Xuân.


Xuan Baldauf wrote:

> Hello,
>
> I'm using linux-2.4.5-pre5 and experiencing following
> message in the syslog. Short after that message, the
> machine locks up hard. This seems to be the same bug
> reported in <3AB0451B.AE06E42C@corp.elong.com>,
> <003801c0ac61$0db49ec0$4f7c14ac@cguri> and in
> <E14XzUK-0004vW-00@halfway>. Is there any fix or
> workaround available?
>
> Xuân.
>
>
> router|12:11:00|~> grep </var/log/messages LIST_DEL
> Jun  6 15:28:05 router kernel: LIST_DELETE:
> ip_conntrack_core.c:165
> `&ct->tuplehash[IP_CT_DIR_REPLY]'(c457e084) not in
> &ip_conntrack_hash
> [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].
> Jun  7 11:54:16 router kernel: LIST_DELETE:
> ip_conntrack_core.c:165
> `&ct->tuplehash[IP_CT_DIR_REPLY]'(c1a00084) not in
> &ip_conntrack_hash
> [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].
> router|12:11:06|~> uname -a
> Linux router 2.4.5-pre5 #14 Thu Jun 7 02:02:58 CEST 2001
> i586 unknown
> router|12:11:20|~>
>
>



