Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132966AbQLHWgd>; Fri, 8 Dec 2000 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132963AbQLHWgX>; Fri, 8 Dec 2000 17:36:23 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:15634 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132953AbQLHWgM>; Fri, 8 Dec 2000 17:36:12 -0500
Message-ID: <3A315B36.208ACE91@baldauf.org>
Date: Fri, 08 Dec 2000 23:05:42 +0100
From: 520042475122-0001@t-online.de (Xuan Baldauf)
Organization: Medium.net
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: netfilter-devel@us5.samba.org, linux-kernel@vger.kernel.org
Subject: [patch] conntrack and skb
Content-Type: multipart/mixed;
 boundary="------------E1201A989522D32341B9CE70"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E1201A989522D32341B9CE70
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Resent patch, hope that it will be acknowledged or discussed.

Xuân. :o)


--------------E1201A989522D32341B9CE70
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3A299A32.46B8FAC2@baldauf.org>
Date: Sun, 03 Dec 2000 01:56:19 +0100
From: Xuan Baldauf <xuan--netfilter-devel@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: netfilter@lists.samba.org
Subject: [patch] conntrack and skb
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,

I discovered a bug in netfilter and worked the last 4 days to track it
down (I'm not a kernel hacker...):

Symptoms:
"Sometimes" the ip_conntrack module won't unload. rmmod or modprobe -r
would stay unkillably and eat all your CPU time (as showable in top).

Analysis:
rmmod sometimes loops in ip_conntrack_cleanup() with

 i_see_dead_people:
  ip_ct_selective_cleanup(kill_all, NULL);
  if (atomic_read(&ip_conntrack_count) != 0) {
    schedule();
    goto i_see_dead_people;
  }

So why is ip_conntrack_count!=0? Discovering this is a very long story,
but in short: Every socket has a queue of skbs which are to be read.
Every skb (call it network packet meta data if you want) can hold a
reference to a conntrack structure. Every conntrack structure is
refcounted with ip_conntrack_count. When skbs are destroyed, there
potential references to conntrack structures are freed. So what happens
if skbs are not destroyed? Gee, they do not free their conntrack
structure references and therefore do not free conntrack data and
therefore do not let the module clean up itself. And when happens this
case? It's rare, but it happens, exactly if a process has input data on
its socket and this input data is not read. This happend a couple of
times for me, sometimes with BIND, sometimes with smbfs.

Fix:
I searched for a global skb list to search for on module cleanup, but
found no one. So I searched for a global "struct sock" list to search
for it's skb queues, but found no one. So I search for a global "struct
socket" list to search for its "struct sock" members, but found no one.
So I searched for a global filedescriptor list and gave up, because
shared filedescriptors are not deemed to be fully race safe, comments
stated. So what did I do? If I assume that the only case a skb stays
long in the system is in a socket receive queue, the only case where
this can be is after "local delivery". So I clear the conntrack
reference early after local delivery (and assume that the packet already
passed iptables, so conntrack references are not needed anymore):

(patch again linux-2.4.0-test10 with all iptables 1.1.2 patches
applied:)

--- linux/net/ipv4/ip_input.c.orig      Sun Dec  3 00:37:42 2000
+++ linux/net/ipv4/ip_input.c   Sun Dec  3 00:49:12 2000
@@ -225,6 +225,26 @@
        nf_debug_ip_local_deliver(skb);
 #endif /*CONFIG_NETFILTER_DEBUG*/

+#ifdef CONFIG_NETFILTER
+       /*
+               Free the reference from the skb to a possible conntrack
early,
+               else an skb could stay for an arbitrary amount of time
in the
+               socket-receive-queue (for hours!) and hence delay
unloading of
+               the ip_conntrack module, which would lead to useless CPU
time
+               consumption and a module state where the module is
neither
+               unloadable nor loadable (since ip_conntrack_cleanup
would still
+               be looping...).
+
+               Connection tracking is done in more early stages, so we
can
+               free the conntrack:
+       */
+       nf_conntrack_put(skb->nfct);
+       skb->nfct = NULL;
+#ifdef CONFIG_NETFILTER_DEBUG
+       skb->nf_debug = 0;
+#endif /*CONFIG_NETFILTER_DEBUG*/
+#endif /*CONFIG_NETFILTER*/
+
        /* Free rx_dev before enqueueing to sockets */
        if (skb->rx_dev) {
                dev_put(skb->rx_dev);


If you want to reproduce that case (before applying this patch):

Type following: (I assume that you have killall, which kills all
processes of a given name)

modprobe ip_conntrack
( /usr/sbin/nc -l -p 1234|sleep 10000 ; echo output done ) &
cat /var/log/messages | ( /usr/sbin/nc localhost 1234; echo input done )
&
( rmmod ip_conntrack ; echo rmmod done ) &
# wait here
ps aux|grep rmmod
# wait here
killall nc

It might show as follows:

router|01:30:51|~> modprobe ip_conntrack
router|01:30:59|~> ( /usr/sbin/nc -l -p 1234|sleep 10000 ; echo output
done ) &
[1] 14866
router|01:31:05|~> cat /var/log/messages | ( /usr/sbin/nc localhost
1234; echo input done ) &
[2] 14870
router|01:31:08|~> ( rmmod ip_conntrack ; echo rmmod done ) &
[3] 14872
router|01:31:10|~> ps aux|grep rmmod
root     14873 85.5  0.4  1144  348 pty/s5   R    01:31   0:01 rmmod
ip_conntrack
root     14875  0.0  0.6  1288  492 pty/s5   S    01:31   0:00 grep
rmmod
# rmmod will still run until nc is killed, which is definitely a bug
router|01:31:13|~> killall nc
 punt!
input done
[2]-  Done                    cat /var/log/messages | ( /usr/sbin/nc
localhost 1234; echo input done )
router|01:31:21|~> rmmod done

[3]+  Done                    ( rmmod ip_conntrack; echo rmmod done )
router|01:31:22|~>



I hope I could help :-)

Xuân Baldauf.




--------------E1201A989522D32341B9CE70--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
