Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313509AbSDYXWZ>; Thu, 25 Apr 2002 19:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313512AbSDYXWY>; Thu, 25 Apr 2002 19:22:24 -0400
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:57097 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S313509AbSDYXWW>; Thu, 25 Apr 2002 19:22:22 -0400
Subject: AES encryption in ethernet bridge
From: Torrey Hoffman <thoffman@arnor.net>
To: Bridge List <bridge@math.leidenuniv.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Apr 2002 16:25:51 -0700
Message-Id: <1019777152.2976.159.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've created a version of the ethernet bridge driver which can encrypt
or decrypt frames as they pass through the bridge.  It uses the AES
algorithm with 128-bit keys, and uses a different key for each
destination address.  

You can get the code at http://www.arnor.net/encryptingbridge/
consisting of a kernel patch against 2.4.17-pre7, and a tarball with a
modified brctl library and application.

This is not a general-purpose network encryption system.  It is a tool
for software developers who are building custom encryption systems.

(This is not as polished as I'd hoped to get it before release, but I
have to look at a proprietary encryption system under NDA real soon now
and wanted to get this out to the world before I'm contaminated, so here
it is.  "It Works For Me". )

Anyone who uses it will probably need to hack on it a little.  It is
easy to modify the code to adjust the details: what packets to encrypt,
what to do with packets that are not encrypted, etc. It is also possible
to specify the destination addresses by IP instead of MAC, this is a bit
of a kluge but it works.

As the patch is written, the bridge will encrypt UDP packets, drop all
non-IP packets, and pass everything else through unencrypted, but this
is easy to change.

The interesting bits of code to customize this further are the
br_aes_encrypt_frame() and br_aes_decrypt_frame() functions in
br_aes_glue.c, along with the br_handle_frame() function in br_input.c.


So what is it good for?

I put this together to encrypt multiple streams of MPEG video across a
network. The video source is a server which can simultaneously stream
dozens of ~4 Mbps streams out to multiple network clients. The goal is
to prevent attackers from copying the video off the network using a
packet sniffer. Putting this encrypting bridge between the server and
the network makes it possible to encrypt all the streams, using a unique
128-bit AES key for every client. 

Since the encryption is done in the kernel, very little latency or
packet timing variation is introduced to the stream.  I decrypt the
video stream in the client application.


Copyright and licensing

The AES encryption and decryption code included in this patch was
written by, and is Copyright (c) 2001, Dr Brian Gladman. (I made small
modifications to the header files to compile them into the kernel
module.) Dr. Gladman's web page at
http://fp.gladman.plus.com/cryptography_technology/rijndael/
has his software, documentation, and other information.

The rest of the code is based on the standard Linux ethernet bridge
code, together with ideas and code lifted from the macprotofilter patch
and the AES loopback driver patch. 

Thanks to all those developers who made it so easy for me to create
this.  The code is GPL'ed of course, aside from the large part written
by Dr. Gladman which is under a more permissive license.


Limitations

This code doesn't do any key management, that is left to userspace to
handle.

The modified version of the "brctl" command-line app allows you to
specify (key,address) pairs for encryption or decryption, and to disable
encryption or decryption to destination addresses.

Decryption in the bridge has not been tested yet. (I do decryption in
the client application). The "showcryptmacs" command for brctl is not
fully implemented. 

I hope to get around to both of those eventually.

Email me at thoffman@arnor.net with  bug reports, comments, questions,
suggestions... and patches are welcome

Torrey Hoffman
thoffman@arnor.net



