Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131789AbRBDPQC>; Sun, 4 Feb 2001 10:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRBDPPx>; Sun, 4 Feb 2001 10:15:53 -0500
Received: from ip167-106.fli-ykh.psinet.ne.jp ([210.129.167.106]:28356 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131789AbRBDPPh>;
	Sun, 4 Feb 2001 10:15:37 -0500
Message-ID: <3A7D7210.EA87572A@yk.rim.or.jp>
Date: Mon, 05 Feb 2001 00:15:28 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /usr/src/linux/scripts/ver_linux prints out incorrect info when "ls" is 
 aliased.
Content-Type: multipart/mixed;
 boundary="------------264A6E2345008D0B29D6BC48"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------264A6E2345008D0B29D6BC48
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

I just noticed that running

        .   /usr/src/linux/script/ver_linux

prints out strange libc version when I run it
as a normal user. It prints out expected output if
I run it as superuser.

Output Example: Incorrect and correct examples.

  Binutils               2.10.0.26
! Linux C Library        1.3.so*
  Dynamic linker         ldd: version 1.9.11
--- 7,9 ----
  Binutils               2.10.0.26
! Linux C Library        2.1.3
  Dynamic linker         ldd: version 1.9.11


After playing with the ver_linux script,
I found that if the command "ls" is aliased to
"ls -aF", the output is incorrect.

Not that I alias "ls" for superuser, but
I usually write bug report, etc. in
a normal user account, and ls is
aliased to "ls -aF" there.

Here is a potential fix to "ver_script".
(Given the possibility of various shell binaries/shell
startup code setting, etc., I think the
common denomiator solution is to use the output of
which as the name of the ls binary.)

I didn't change the handling of other commands.
"ls" is likely to be aliased, but I wonder
whether other commands are aliased. YMMV.

Possible fix to ver_script is attached.








--------------264A6E2345008D0B29D6BC48
Content-Type: text/plain; charset=iso-2022-jp;
 name="ver_linux.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux.diff"


*** ver_linux	Sun Feb  4 23:53:11 2001
--- /tmp/ver_linux	Mon Feb  5 00:00:54 2001
***************
*** 7,12 ****
--- 7,19 ----
  PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
  echo '-- Versions installed: (if some fields are empty or look'
  echo '-- unusual then possibly you have very old versions)'
+ 
+ # to avoid the effect of aliasing "ls" command.
+ # YMMV.
+ # (I am not sure if other commands require similar
+ #  treatment.)
+ LS=`which ls`
+ 
  uname -a
  insmod -V  2>&1 | awk 'NR==1 {print "Kernel modules        ",$NF}'
  echo "Gnu C                 " `gcc --version`
***************
*** 14,24 ****
        '/GNU Make/{print "Gnu Make              ",$NF}'
  ld -v 2>&1 | awk -F\) '{print $1}' | awk \
        '/BFD/{print "Binutils              ",$NF}'
! ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed -e 's/\.so$//' \
    | awk -F'[.-]'   '{print "Linux C Library        " $(NF-2)"."$(NF-1)"."$NF}'
  echo -n "Dynamic linker         "
  ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1
! ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
         '{print "Linux C++ Library      " $4"."$5"."$6}'
  ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'
  mount --version | awk -F\- '{print "Mount                 ", $NF}'
--- 21,31 ----
        '/GNU Make/{print "Gnu Make              ",$NF}'
  ld -v 2>&1 | awk -F\) '{print $1}' | awk \
        '/BFD/{print "Binutils              ",$NF}'
! ${LS} -l `ldd /bin/sh | awk '/libc/ { print $3 } ' ` | sed -e 's/\.so$//' \
    | awk -F'[.-]'   '{print "Linux C Library        " $(NF-2)"."$(NF-1)"."$NF}'
  echo -n "Dynamic linker         "
  ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1
! ${LS} -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
         '{print "Linux C++ Library      " $4"."$5"."$6}'
  ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'
  mount --version | awk -F\- '{print "Mount                 ", $NF}'

--------------264A6E2345008D0B29D6BC48--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
