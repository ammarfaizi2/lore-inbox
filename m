Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTJIHj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 03:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJIHj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 03:39:56 -0400
Received: from mail.eee.strath.ac.uk ([130.159.72.152]:53000 "EHLO
	hermes.eee.strath.ac.uk") by vger.kernel.org with ESMTP
	id S261916AbTJIHjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 03:39:47 -0400
Date: Thu, 9 Oct 2003 07:27:15 -0000
To: <linux-net@vger.kernel.org>
Subject: patch to implement RFC3517 in linux 2.4.22
From: "Douglas Leith" <doug@eee.strath.ac.uk>
X-Mailer: TWIG 2.6.2
Cc: <davem@redhat.com>, <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>,
       <jmorris@intercode.com.au>, <yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--------part3f850dd403f50"
Message-Id: <E1A7VCe-0001lZ-00@hermes.eee.strath.ac.uk>
X-Scanner: exiscan *1A7VCe-0001lZ-00*5ejxiXm5iAo* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----------part3f850dd403f50
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a short patch against version 2.4.22 to implement the recent 
rfc3517 for SACK in TCP (see ftp://ftp.rfc-editor.org/in-notes/rfc3517.txt).  
This modifies how packets which fail to be sacked are marked as lost.  At 
present, any packets falling into sack holes are marked lost after the first 
successful retransmit.  The new code marks packets in sack holes as lost as 
soon as tp->reordering or more packets with higher sequence number are 
sacked.  This is consistent with how reordering is handled elsewhere and 
should lead to faster retransmission and recovery when multiple drops occur.

Comments appreciated.

Regards,

Doug Leith

www.hamilton.ie


diff -u -wbrP --exclude=config.save linux-2.4.22/net/ipv4/tcp_input.c linux-
2.4.22-retrans/net/ipv4/tcp_input.c
--- linux-2.4.22/net/ipv4/tcp_input.c   2003-06-13 15:51:39.000000000 +0100
+++ linux-2.4.22-retrans/net/ipv4/tcp_input.c   2003-10-09 07:59:48.000000000 
+0100
@@ -61,6 +61,7 @@
  *             Panu Kuhlberg:          Experimental audit of TCP (re)
transmission
  *                                     engine. Lots of bugs are found.
  *             Pasi Sarolahti:         F-RTO for dealing with spurious RTOs
+ *             Doug Leith:             Early retransmission of packets 
falling into sack holes.
  */

 #include <linux/config.h>
@@ -757,6 +758,10 @@
  *    for retransmitted and already SACKed segment -> reordering..
  * Both of these heuristics are not used in Loss state, when we cannot
  * account for retransmits accurately.
+ *
+ * Retransmission of packets
+ * -------------------------
+ * Extension of Hoe's retransmit to allow early retransmission of packets 
which fall into sack holes
  */
 static int
 tcp_sacktag_write_queue(struct sock *sk, struct sk_buff *ack_skb, u32 
prior_snd_una)
@@ -770,6 +775,7 @@
        u32 lost_retrans = 0;
        int flag = 0;
        int i;
+        u32 prior_sacked_out=tp->sacked_out;

        if (!tp->sacked_out)
                tp->fackets_out = 0;
@@ -781,6 +787,7 @@
                __u32 end_seq = ntohl(sp->end_seq);
                int fack_count = 0;
                int dup_sack = 0;
+                u32 sack_count=0;

                /* Check for D-SACK. */
                if (i == 0) {
@@ -828,6 +835,8 @@
                                break;

                        fack_count++;
+                       if (sacked&TCPCB_RETRANS)
+                          sack_count++;

                        in_sack = !after(start_seq, TCP_SKB_CB(skb)->seq) &&
                                !before(end_seq, TCP_SKB_CB(skb)->end_seq);
@@ -860,8 +869,14 @@
                            (!lost_retrans || after(end_seq, lost_retrans)))
                                lost_retrans = end_seq;

-                       if (!in_sack)
+                       if (!in_sack) {
+                           /* force early retransmit ? */
+                           if (!(sacked&TCPCB_TAGBITS) && (prior_sacked_out 
> sack_count + tp->reordering)) {
+                               TCP_SKB_CB(skb)->sacked |= TCPCB_LOST;
+                               tp->lost_out++;
+                           }
                                continue;
+                       }

                        if (!(sacked&TCPCB_SACKED_ACKED)) {
                                if (sacked & TCPCB_SACKED_RETRANS) {
@@ -1599,7 +1614,7 @@
        if ((flag&FLAG_DATA_LOST) &&
            before(tp->snd_una, tp->high_seq) &&
            tp->ca_state != TCP_CA_Open &&
-           tp->fackets_out > tp->reordering) {
+           tp->fackets_out > tp->reordering && IsReno(tp) ) {
                tcp_mark_head_lost(sk, tp, tp->fackets_out-tp->reordering, tp-
>high_seq);
                NET_INC_STATS_BH(TCPLoss);
        }
@@ -1714,7 +1729,7 @@
                tp->ca_state = TCP_CA_Recovery;
        }

-       if (is_dupack || tcp_head_timedout(sk, tp))
+       if ( (is_dupack || tcp_head_timedout(sk, tp)) && IsReno(tp) )
                tcp_update_scoreboard(sk, tp);
        tcp_cwnd_down(tp);
        tcp_xmit_retransmit_queue(sk);



----------part3f850dd403f50
Content-Type: text/plain; name="rfc3517.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtdSAtd2JyUCAtLWV4Y2x1ZGU9Y29uZmlnLnNhdmUgbGludXgtMi40LjIyL25ldC9pcHY0
L3RjcF9pbnB1dC5jIGxpbnV4LTIuNC4yMi1yZXRyYW5zL25ldC9pcHY0L3RjcF9pbnB1dC5jCi0t
LSBsaW51eC0yLjQuMjIvbmV0L2lwdjQvdGNwX2lucHV0LmMJMjAwMy0wNi0xMyAxNTo1MTozOS4w
MDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNC4yMi1yZXRyYW5zL25ldC9pcHY0L3RjcF9pbnB1
dC5jCTIwMDMtMTAtMDkgMDc6NTk6NDguMDAwMDAwMDAwICswMTAwCkBAIC02MSw2ICs2MSw3IEBA
CiAgKgkJUGFudSBLdWhsYmVyZzoJCUV4cGVyaW1lbnRhbCBhdWRpdCBvZiBUQ1AgKHJlKXRyYW5z
bWlzc2lvbgogICoJCQkJCWVuZ2luZS4gTG90cyBvZiBidWdzIGFyZSBmb3VuZC4KICAqCQlQYXNp
IFNhcm9sYWh0aToJCUYtUlRPIGZvciBkZWFsaW5nIHdpdGggc3B1cmlvdXMgUlRPcworICoJCURv
dWcgTGVpdGg6CQlFYXJseSByZXRyYW5zbWlzc2lvbiBvZiBwYWNrZXRzIGZhbGxpbmcgaW50byBz
YWNrIGhvbGVzLgogICovCiAKICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KQEAgLTc1Nyw2ICs3
NTgsMTAgQEAKICAqICAgIGZvciByZXRyYW5zbWl0dGVkIGFuZCBhbHJlYWR5IFNBQ0tlZCBzZWdt
ZW50IC0+IHJlb3JkZXJpbmcuLgogICogQm90aCBvZiB0aGVzZSBoZXVyaXN0aWNzIGFyZSBub3Qg
dXNlZCBpbiBMb3NzIHN0YXRlLCB3aGVuIHdlIGNhbm5vdAogICogYWNjb3VudCBmb3IgcmV0cmFu
c21pdHMgYWNjdXJhdGVseS4KKyAqCisgKiBSZXRyYW5zbWlzc2lvbiBvZiBwYWNrZXRzCisgKiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisgKiBFeHRlbnNpb24gb2YgSG9lJ3MgcmV0cmFuc21p
dCB0byBhbGxvdyBlYXJseSByZXRyYW5zbWlzc2lvbiBvZiBwYWNrZXRzIHdoaWNoIGZhbGwgaW50
byBzYWNrIGhvbGVzCiAgKi8KIHN0YXRpYyBpbnQKIHRjcF9zYWNrdGFnX3dyaXRlX3F1ZXVlKHN0
cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKmFja19za2IsIHUzMiBwcmlvcl9zbmRfdW5h
KQpAQCAtNzcwLDYgKzc3NSw3IEBACiAJdTMyIGxvc3RfcmV0cmFucyA9IDA7CiAJaW50IGZsYWcg
PSAwOwogCWludCBpOworICAgICAgICB1MzIgcHJpb3Jfc2Fja2VkX291dD10cC0+c2Fja2VkX291
dDsKIAogCWlmICghdHAtPnNhY2tlZF9vdXQpCiAJCXRwLT5mYWNrZXRzX291dCA9IDA7CkBAIC03
ODEsNiArNzg3LDcgQEAKIAkJX191MzIgZW5kX3NlcSA9IG50b2hsKHNwLT5lbmRfc2VxKTsKIAkJ
aW50IGZhY2tfY291bnQgPSAwOwogCQlpbnQgZHVwX3NhY2sgPSAwOworICAgICAgICAgICAgICAg
IHUzMiBzYWNrX2NvdW50PTA7CiAKIAkJLyogQ2hlY2sgZm9yIEQtU0FDSy4gKi8KIAkJaWYgKGkg
PT0gMCkgewpAQCAtODI4LDYgKzgzNSw4IEBACiAJCQkJYnJlYWs7CiAKIAkJCWZhY2tfY291bnQr
KzsKKwkJCWlmIChzYWNrZWQmVENQQ0JfUkVUUkFOUykgCisJCQkgICBzYWNrX2NvdW50Kys7CiAK
IAkJCWluX3NhY2sgPSAhYWZ0ZXIoc3RhcnRfc2VxLCBUQ1BfU0tCX0NCKHNrYiktPnNlcSkgJiYK
IAkJCQkhYmVmb3JlKGVuZF9zZXEsIFRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcSk7CkBAIC04NjAs
OCArODY5LDE0IEBACiAJCQkgICAgKCFsb3N0X3JldHJhbnMgfHwgYWZ0ZXIoZW5kX3NlcSwgbG9z
dF9yZXRyYW5zKSkpCiAJCQkJbG9zdF9yZXRyYW5zID0gZW5kX3NlcTsKIAotCQkJaWYgKCFpbl9z
YWNrKQorCQkJaWYgKCFpbl9zYWNrKSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBm
b3JjZSBlYXJseSByZXRyYW5zbWl0ID8gKi8KKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlm
ICghKHNhY2tlZCZUQ1BDQl9UQUdCSVRTKSAmJiAocHJpb3Jfc2Fja2VkX291dCA+IHNhY2tfY291
bnQgKyB0cC0+cmVvcmRlcmluZykpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
Q1BfU0tCX0NCKHNrYiktPnNhY2tlZCB8PSBUQ1BDQl9MT1NUOyAKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB0cC0+bG9zdF9vdXQrKzsKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0KIAkJCQljb250aW51ZTsKKyAJCQl9CiAKIAkJCWlmICghKHNhY2tlZCZUQ1BDQl9TQUNLRURf
QUNLRUQpKSB7CiAJCQkJaWYgKHNhY2tlZCAmIFRDUENCX1NBQ0tFRF9SRVRSQU5TKSB7CkBAIC0x
NTk5LDcgKzE2MTQsNyBAQAogCWlmICgoZmxhZyZGTEFHX0RBVEFfTE9TVCkgJiYKIAkgICAgYmVm
b3JlKHRwLT5zbmRfdW5hLCB0cC0+aGlnaF9zZXEpICYmCiAJICAgIHRwLT5jYV9zdGF0ZSAhPSBU
Q1BfQ0FfT3BlbiAmJgotCSAgICB0cC0+ZmFja2V0c19vdXQgPiB0cC0+cmVvcmRlcmluZykgewor
CSAgICB0cC0+ZmFja2V0c19vdXQgPiB0cC0+cmVvcmRlcmluZyAmJiBJc1Jlbm8odHApICkgewog
CQl0Y3BfbWFya19oZWFkX2xvc3Qoc2ssIHRwLCB0cC0+ZmFja2V0c19vdXQtdHAtPnJlb3JkZXJp
bmcsIHRwLT5oaWdoX3NlcSk7CiAJCU5FVF9JTkNfU1RBVFNfQkgoVENQTG9zcyk7CiAJfQpAQCAt
MTcxNCw3ICsxNzI5LDcgQEAKIAkJdHAtPmNhX3N0YXRlID0gVENQX0NBX1JlY292ZXJ5OwogCX0K
IAotCWlmIChpc19kdXBhY2sgfHwgdGNwX2hlYWRfdGltZWRvdXQoc2ssIHRwKSkKKwlpZiAoIChp
c19kdXBhY2sgfHwgdGNwX2hlYWRfdGltZWRvdXQoc2ssIHRwKSkgJiYgSXNSZW5vKHRwKSApCiAJ
CXRjcF91cGRhdGVfc2NvcmVib2FyZChzaywgdHApOwogCXRjcF9jd25kX2Rvd24odHApOwogCXRj
cF94bWl0X3JldHJhbnNtaXRfcXVldWUoc2spOwo=




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
----------part3f850dd403f50--
