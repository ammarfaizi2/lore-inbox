Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSGVRPp>; Mon, 22 Jul 2002 13:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSGVRPp>; Mon, 22 Jul 2002 13:15:45 -0400
Received: from perfo.perfopol.pl ([213.25.186.10]:6154 "EHLO mail.perfopol.pl")
	by vger.kernel.org with ESMTP id <S316684AbSGVRPo> convert rfc822-to-8bit;
	Mon, 22 Jul 2002 13:15:44 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH: 2.5.27] fix scripts/mkcompile_h for non-bash shells
X-Attribution: arekm
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
Organization: PLD Linux Distribution Team
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Date: 22 Jul 2002 18:23:32 +0200
Message-ID: <87bs8zlojf.fsf@arm.t19.ds.pwr.wroc.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.90
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With pdksh as /bin/sh

[root@arm linux-2.5.27]# make bzImage
make[1]: Wchodzê w katalog `/usr/src/linux-2.5.27/scripts'
make[1]: Opuszczam katalog `/usr/src/linux-2.5.27/scripts'
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make[1]: Wchodzê w katalog `/usr/src/linux-2.5.27/init'
  Generating /usr/src/linux-2.5.27/include/linux/compile.hsed: can't read s/\(.\64\\).*/\1/: No such file or directory
sed: can't read s/\(.\64\\).*/\1/: No such file or directory
sed: can't read s/\(.\64\\).*/\1/: No such file or directory
 (unchanged)
make[1]: Opuszczam katalog `/usr/src/linux-2.5.27/init'

That's due to expanding of sed expression done by shell:

[misiek@arm misiek]$ sh
[\u@\h \W]$ UTS_TRUNCATE='sed -e s/\(.\{1,$UTS_LEN\}\).*/\1/' 
[\u@\h \W]$ echo $UTS_TRUNCATE
sed -e s/\(.\1\).*/\1/ s/\(.\$UTS_LEN\).*/\1/


This little change fixes that:

--- scripts/mkcompile_h.org     Mon Jul 22 18:15:33 2002
+++ scripts/mkcompile_h Mon Jul 22 18:15:55 2002
@@ -3,6 +3,9 @@
 SMP=$3
 CC=$4
 
+# Do not expand names
+set -f
+
 if [ -r ../.version ]; then
   VERSION=`cat ../.version`
 else


-- 
Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr

