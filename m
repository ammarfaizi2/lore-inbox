Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRHSWmx>; Sun, 19 Aug 2001 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRHSWmn>; Sun, 19 Aug 2001 18:42:43 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:39172 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270825AbRHSWmh>; Sun, 19 Aug 2001 18:42:37 -0400
Message-ID: <3B8040BF.F1B24374@leo.org>
Date: Mon, 20 Aug 2001 00:42:07 +0200
From: Joachim Herb <herb@leo.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compilation error in ntfs driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I think I have found a compilation error in the ntfs driver in file
unistr.c:
make -C ntfs modules
make[2]: Entering directory `/usr/src/linux-2.4.7/fs/ntfs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o
unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'

The problem is the following part of the 2.4.9 patch:
diff -u --recursive --new-file v2.4.8/linux/fs/ntfs/unistr.c
linux/fs/ntfs/unistr.c
--- v2.4.8/linux/fs/ntfs/unistr.c       Wed Jul 25 17:10:24 2001
+++ linux/fs/ntfs/unistr.c      Wed Aug 15 01:22:17 2001
@@ -96,7 +96,7 @@
        __u32 cnt;
        wchar_t c1, c2;
 
-       for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)
+       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len);
++cnt)
        {
                c1 = le16_to_cpu(*name1++);
                c2 = le16_to_cpu(*name2++);

Simply remove it again, i.e. remove the "unsigned int, ", and the file
compiles (with one warning).

Joachim
-- 
Joachim Herb
mailto:herb@leo.org
