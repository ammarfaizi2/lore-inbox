Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSKERsE>; Tue, 5 Nov 2002 12:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSKERsD>; Tue, 5 Nov 2002 12:48:03 -0500
Received: from catv-d5de80ec.bp11catv.broadband.hu ([213.222.128.236]:13585
	"EHLO balabit.hu") by vger.kernel.org with ESMTP id <S265092AbSKERsC>;
	Tue, 5 Nov 2002 12:48:02 -0500
Date: Tue, 5 Nov 2002 18:54:33 +0100
From: Balazs Scheidler <bazsi@balabit.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unix domain sockets bugfix
Message-ID: <20021105175433.GB16347@balabit.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-rc1, still not working well for recvfrom() of unix-dgram sockets. It
doesn't return 0 as the length of the sockaddr, checking out the code again
makes me think that this is the problem:

--- socket.c.old	Tue Nov  5 18:48:22 2002
+++ socket.c	Tue Nov  5 18:49:34 2002
@@ -1262,7 +1262,7 @@
 		flags |= MSG_DONTWAIT;
 	err=sock_recvmsg(sock, &msg, size, flags);
 
-	if(err >= 0 && addr != NULL && msg.msg_namelen)
+	if(err >= 0 && addr != NULL)
 	{
 		err2=move_addr_to_user(address, msg.msg_namelen, addr, addr_len);
 		if(err2<0)
---------

strace for the behaviour of the kernel:

> recvfrom(3, "<38>Nov  5 17:53:01 PAM_unix[952"..., 2048, 0, {sin_family=0xf80c /* AF_??? */, {sa_family=63500, sa_data="\377\27
> 7\6\351\4\10\10\270\5\10\360@\5\10"}, [256]) = 82

you can see that 256 is returned as the length of the sockaddr, and there's garbage in the sa_family field.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
