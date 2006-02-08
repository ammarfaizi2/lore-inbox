Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWBHBuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWBHBuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWBHBuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:50:05 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:5381 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965164AbWBHBuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:50:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=uJ8UteGCINyqoQ5YWOF6KPh60nm3woqGMEmrA/uyv03szJnr54tUOkA4ojbrILi+oCayVj61SDBo/92/k+30Cudsk6BzOCMYLSnK3JI2M0LSS4UZuwUj9s6za0ay3xc3ouySIrsNDvyagQ+PXmbd63wxfgCNrFEC2umTxzO3XGI=
Message-ID: <9fda5f510602071750o53f76fc8gc94c280a9998343d@mail.gmail.com>
Date: Tue, 7 Feb 2006 17:50:03 -0800
From: Pradeep Vincent <pradeep.vincent@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060207215341.GC11380@w.ods.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_336_14278017.1139363403092"
References: <9fda5f510511281257o364acb3gd634f8e412cd7301@mail.gmail.com>
	 <9fda5f510602031806j2f9ef743t206c9ee2c3bef384@mail.gmail.com>
	 <20060203.181839.104353534.davem@davemloft.net>
	 <9fda5f510602062357n38292cebk3c5738ccdbee83@mail.gmail.com>
	 <20060207215341.GC11380@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_336_14278017.1139363403092
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

One more attempt. Attaching the diff file as well.

Signed off by: Pradeep Vincent <pradeep.vincent@gmail.com>

--- old/net/core/neighbour.c    Wed Nov  9 16:48:10 2005
+++ new/net/core/neighbour.c    Tue Feb  7 17:38:26 2006
@@ -14,6 +14,7 @@
  *     Vitaly E. Lavrov        releasing NULL neighbor in neigh_add.
  *     Harald Welte            Add neighbour cache statistics like rtstat
  *     Harald Welte            port neighbour cache rework from 2.6.9-rcX
+ *     Pradeep Vincent         fix neighbour cache state machine
  */

 #include <linux/config.h>
@@ -705,6 +706,13 @@
                        neigh_release(n);
                        continue;
                }
+               /* Move to NUD_STALE state */
+               if (n->nud_state&NUD_REACHABLE &&
+                   now - n->confirmed > n->parms->reachable_time) {
+                       n->nud_state =3D NUD_STALE;
+                       neigh_suspect(n);
+               }
+
                write_unlock(&n->lock);

 next_elt:

Thanks,

Pradeep
On 2/7/06, Willy Tarreau <willy@w.ods.org> wrote:
> Hi,
>
> On Tue, Feb 07, 2006 at 12:57:43AM -0700, Pradeep Vincent wrote:
> > In 2.4.21, arp code uses gc_timer to check for stale arp cache
> > entries. In 2.6, each entry has its own timer to check for stale arp
> > cache. 2.4.29 to 2.4.32 kernels (atleast) use neither of these timers.
> > This causes problems in environments where IPs or MACs are reassigned
> > - saw this problem on load balancing router based networks that use
> > VMACs. Tested this code on load balancing router based networks as
> > well as peer-linux systems.
> >
> >
> > Thanks,
> >
> >
> > Signed off by: Pradeep Vincent <pradeep.vincent@gmail.com>
> >
> > diff -Naur old/net/core/neighbour.c new/net/core/neighbour.c
> > --- old/net/core/neighbour.c    Wed Nov 23 17:15:30 2005
> > +++ new/net/core/neighbour.c    Wed Nov 23 17:26:01 2005
> > @@ -14,6 +14,7 @@
> > *     Vitaly E. Lavrov        releasing NULL neighbor in neigh_add.
> > *     Harald Welte            Add neighbour cache statistics like rtsta=
t
> > *     Harald Welte            port neighbour cache rework from 2.6.9-rc=
X
> > + *      Pradeep Vincent         Move neighbour cache entry to stale st=
ate
> > */
>
> As you can see above, your mailer is still broken. Leading spaces get
> removed and it seems like tabs are replaced with spaces. This makes it
> really annoying to fix by hand because we all have to do your work again.
> You should try to fix your mailer options, possibly by sending a few
> mails to yourself or someone else (if you send *a few* mails to me, I
> can confirm which one looks OK). If your mailer is definitely broken,
> then you may send it as plain text first (for review), with a text
> attachment for people to apply it without trouble.
>
> Thanks,
> Willy
>
>

------=_Part_336_14278017.1139363403092
Content-Type: application/octet-stream; name="linux-2.4.29-arp-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.4.29-arp-fix.patch"
X-Attachment-Id: f_ejezhtjs

LS0tIG9sZC9uZXQvY29yZS9uZWlnaGJvdXIuYwlXZWQgTm92ICA5IDE2OjQ4OjEwIDIwMDUKKysr
IG5ldy9uZXQvY29yZS9uZWlnaGJvdXIuYwlUdWUgRmViICA3IDE3OjM4OjI2IDIwMDYKQEAgLTE0
LDYgKzE0LDcgQEAKICAqCVZpdGFseSBFLiBMYXZyb3YJcmVsZWFzaW5nIE5VTEwgbmVpZ2hib3Ig
aW4gbmVpZ2hfYWRkLgogICoJSGFyYWxkIFdlbHRlCQlBZGQgbmVpZ2hib3VyIGNhY2hlIHN0YXRp
c3RpY3MgbGlrZSBydHN0YXQKICAqCUhhcmFsZCBXZWx0ZQkJcG9ydCBuZWlnaGJvdXIgY2FjaGUg
cmV3b3JrIGZyb20gMi42LjktcmNYCisgKglQcmFkZWVwIFZpbmNlbnQgICAgICAgICBmaXggbmVp
Z2hib3VyIGNhY2hlIHN0YXRlIG1hY2hpbmUgCiAgKi8KIAogI2luY2x1ZGUgPGxpbnV4L2NvbmZp
Zy5oPgpAQCAtNzA1LDYgKzcwNiwxMyBAQAogCQkJbmVpZ2hfcmVsZWFzZShuKTsKIAkJCWNvbnRp
bnVlOwogCQl9CisJCS8qIE1vdmUgdG8gTlVEX1NUQUxFIHN0YXRlICovCisJCWlmIChuLT5udWRf
c3RhdGUmTlVEX1JFQUNIQUJMRSAmJgorCQkgICAgbm93IC0gbi0+Y29uZmlybWVkID4gbi0+cGFy
bXMtPnJlYWNoYWJsZV90aW1lKSB7CisJCQluLT5udWRfc3RhdGUgPSBOVURfU1RBTEU7CisJCQlu
ZWlnaF9zdXNwZWN0KG4pOworCQl9CisKIAkJd3JpdGVfdW5sb2NrKCZuLT5sb2NrKTsKIAogbmV4
dF9lbHQ6Cg==
------=_Part_336_14278017.1139363403092--
