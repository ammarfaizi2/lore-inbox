Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWHADdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWHADdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWHADdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:33:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751202AbWHADdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:33:20 -0400
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17613.16090.470524.736889@cse.unsw.edu.au>
	<ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17614.44057.322945.156592@cse.unsw.edu.au>
	<orpsflrxmb.fsf@free.oliva.athome.lsd.ic.unicamp.br>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Tue, 01 Aug 2006 00:33:04 -0300
In-Reply-To: <orpsflrxmb.fsf@free.oliva.athome.lsd.ic.unicamp.br> (Alexandre Oliva's message of "Mon, 31 Jul 2006 23:35:56 -0300")
Message-ID: <orac6p870v.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

On Jul 31, 2006, Alexandre Oliva <aoliva@redhat.com> wrote:

>> mdadm --assemble --scan --homehost='<system>' --auto-update-homehost \
>> --auto=yes --run

>> in your initrd, having set the hostname correctly first.  It might do
>> exactly what you want.

> I'll give it a try some time tomorrow, since I won't turn on that
> noisy box today any more; my daughter is already asleep :-)

But then, I could use my own desktop to test it :-)

FWIW, here's the patch for Fedora rawhide's mkinitrd that worked for
me.  I figured even without --homehost it worked fine, even without
HOMEHOST set in mdadm.conf.

I hope copying mdadm.conf to initrd won't ever hurt, can you think of
any case in which it would?


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=mkinitrd-mdadm.patch

--- /sbin/mkinitrd	2006-07-26 15:43:41.000000000 -0300
+++ /tmp/mkinitrd	2006-08-01 00:06:14.000000000 -0300
@@ -1240,10 +1240,19 @@
 emitdms
 
 if [ -n "$raiddevices" ]; then
+  if test -f /sbin/mdadm.static; then
+    if test -f /etc/mdadm.conf; then
+      inst /etc/mdadm.conf "$MNTIMAGE/etc/mdadm.conf"
+    fi
+    inst /sbin/mdadm.static "$MNTIMAGE/sbin/mdadm"
+    emit "mkdir /dev/md"
+    emit "mdadm --quiet --assemble --scan --auto-update-homehost --auto=yes --run"
+  else
     for dev in $raiddevices; do
         cp -a /dev/${dev} $MNTIMAGE/dev
         emit "raidautorun /dev/${dev}"
     done
+  fi
 fi
 
 if [ -n "$vg_list" ]; then

--=-=-=


-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
