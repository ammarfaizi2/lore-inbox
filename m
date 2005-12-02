Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVLBWHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVLBWHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVLBWHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:07:50 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:38374 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750891AbVLBWHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:07:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=S2SoQDl6zK+K0IdnU+02cf1yUPPqxh9Ta+xn2jlA+sxdzmoqz+2/C+nhEEA3yeUK9BJlcp7OkasE6CwODaEjg24hdFfw4Qa3VqpmGDCI5IqI7UEUK5eAEfz+0VB696/uoseRiIV61cz92cuqhduLhhIC1aPPNNdJGPRaM2n+9pU=
Message-ID: <a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com>
Date: Fri, 2 Dec 2005 14:07:47 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Bharath Ramesh <krosswindz@gmail.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1006_3002813.1133561267089"
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
	 <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
	 <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1006_3002813.1133561267089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Welcome to hardware bring up.  Ok I looked a little closer at the
story.  In x86_64 the only check for valid apic is apicid < MAX_APICS
which make sense to me.

I386 has this concept of version.  Where the valid check is diffrent

  if (version >=3D 0x14)
                return apicid < 0xff;
        else
                return apicid < 0xf;

Now the patch is sent before was a litle in haste.  Your apic version
is 16. The valid check returns false because apicid is greater that
0xf (0x15).  Most likey the bios entry for the apic version is wrong
but I don't know much about that or why it matters.

So what does this all mean.  Legacy.....

Give this patch a whirl.

Thanks,
 Keith

------=_Part_1006_3002813.1133561267089
Content-Type: application/octet-stream; name=apicid.fix
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apicid.fix"

--- arch/i386/kernel/mpparse.c.orig	2005-12-01 15:20:51.000000000 -0800
+++ arch/i386/kernel/mpparse.c	2005-12-01 15:21:19.000000000 -0800
@@ -112,9 +112,10 @@
 #else
 static int MP_valid_apicid(int apicid, int version)
 {
-	if (version >= 0x14)
+/*	if (version >= 0x14)
 		return apicid < 0xff;
 	else
+*/
 		return apicid < MAX_APICS;
 }
 #endif

------=_Part_1006_3002813.1133561267089--
