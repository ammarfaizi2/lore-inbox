Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVA2Q7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVA2Q7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVA2Q7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:59:03 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16866 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262940AbVA2Q6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:58:49 -0500
Message-ID: <41FBC0EF.8010705@comcast.net>
Date: Sat, 29 Jan 2005 11:59:27 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>	 <1106848051.5624.110.camel@laptopd505.fenrus.org>	 <41F92D2B.4090302@comcast.net>	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>	 <41F95F79.6080904@comcast.net>	 <1106862801.5624.145.camel@laptopd505.fenrus.org>	 <41F96C7D.9000506@comcast.net>	 <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>	 <41FB2DD2.1070405@comcast.net>	 <1106986224.4174.65.camel@laptopd505.fenrus.org>	 <41FBB821.3000403@comcast.net> <1107016955.4174.127.camel@laptopd505.fenrus.org>
In-Reply-To: <1107016955.4174.127.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1





Arjan van de Ven wrote:
> On Sat, 2005-01-29 at 11:21 -0500, John Richard Moser wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
> 
> 
>>These are the only places mprotect() is mentioned; a visual scan
>>confirms no trickery:
>>
>>        if( fork() == 0 ) {
>>                /* Perform a dirty (but not unrealistic) trick to circumvent
>>                 * the kernel protection.
>>                 */
>>                if( paxtest_mode == 1 ) {
>>                        pthread_t thread;
>>                        pthread_create(&thread, NULL, test_thread, dummy);
>>                        doit();
>>                        pthread_kill(thread, SIGTERM);
>>                } else {
> 
> 
>>So, there you have it.  These tests do not intentionally kill
>>exec-shield based on its known issue with tracking the upper limit of
>>the code segment.
> 
> 
> 
> here they do.
> dummy is a local NESTED function, which causes the stack to *correctly*
> be marked executable, due to the need of trampolines. 
> That disables execshield for any tests that use dummy.o, which most of
> them are.
> 

Only in "Blackhat" mode.  I ran in Kiddie and Blackhat mode, and my
second batch of tests (tests.txt, my errata) was run after execstack -c.

> 

root@iceslab:/mnt/redhat/root/paxtest-0.9.6 # strace ./execstack 2>&1 |
grep mprotect
mprotect(0x20822000, 4096, PROT_NONE)   = 0
root@iceslab:/mnt/redhat/root/paxtest-0.9.6 # strace ./execstack 2>&1 |
grep EXEC
old_mmap(NULL, 64996, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x265d9000
old_mmap(NULL, 1232332, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x265e9000
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x26716000

I killed the fork() line and straced it.
0x26716000 is only ~600 megs up,  I find my stack at ~1.5G under
segmexec, I'd guess it'd be at ~3G under normal things like execshield.
 You know what *looks*

getstack1:  0xfefcead7
getstack1:  0xfefe9947
getstack1:  0xfeedd4f7
getstack1:  0xfefe6e37
getstack1:  0xfee412b7
getstack1:  0xfee71737

Yeah it's pretty high under exec shield.

none of these are doing ANYTHING weird (grepping for EXEC and scanning
for PROT_EXEC and related addresses), aside from the normal mapping of
libraries by the system, which is probably what's killing Exec Shield's
anonymous mapping, heap, data, bss, library data, library bss. . .

To put it bluntly, you're wrong.  The tests are valid.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+8DuhDd4aOud5P8RAscYAKCErG3KB5M9gMwZ1BRqTDBKyYYLrACfcYeb
0ptJYTE+uUx0QYSHmKXWlsA=
=PL8+
-----END PGP SIGNATURE-----
