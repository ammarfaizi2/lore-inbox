Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265696AbRFXBrh>; Sat, 23 Jun 2001 21:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbRFXBr1>; Sat, 23 Jun 2001 21:47:27 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:5381 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265696AbRFXBrM>;
	Sat, 23 Jun 2001 21:47:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: stimits@idcomm.com
cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy? 
In-Reply-To: Your message of "Sat, 23 Jun 2001 19:09:12 CST."
             <3B353DB8.578F43FB@idcomm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jun 2001 11:47:04 +1000
Message-ID: <18859.993347224@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001 19:09:12 -0600, 
"D. Stimits" <stimits@idcomm.com> wrote:
>There is a directory on RH 7.1 x86, /lib/i686/. When checking with ldd
>to various applications, as to which libc they link to, it turns out
>that the /lib/libc.so.6 is not used. They all seem to point at
>/lib/i686/libc.so.6 (this is the version with debugging symbols) by
>default. The odd thing is that there are NO LD_ style path variables set
>on this system, there is NO /etc/ld.so.preload, and /etc/ld.so.conf does
>not contain any reference to /lib/i686/. So there is a question of just
>how it is possible for ld to use that directory and ignore /lib/ for
>libc.so.6.

15 minutes with a few commands, man pages and the source of glibc will
show you this ...

# /sbin/ldconfig -p | fgrep -w libc
libc.so.6 (libc6, hwcap: 0x8000000000000, OS ABI: Linux 2.4.1) => /lib/i686/libc.so.6
libc.so.6 (libc6, OS ABI: Linux 2.2.5) => /lib/libc.so.6

The data is coming from /etc/ld.so.cache which is build by ldconfig.
A quick scan of the source for ldconfig.c in glibc 2.2.2 shows that it
starts with standard paths /lib and /usr/lib then searches those
directories and all their subdirectories looking for libraries.  That
explains why it finds /lib/i686 without being explicitly specified.

Note the hwcap entry in /lib/i686/libc.so.6.  The dynamic linker no
longer takes the first entry it finds for a library, instead it looks
for the first entry that matches the current hardware.  This is
required for machines like ia64 which can also run i386 binaries and
for sparc which can run 32 or 64 bit apps.

