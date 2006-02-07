Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWBGXlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWBGXlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWBGXlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:41:20 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:12531 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030284AbWBGXlT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:41:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sZXGMpFHD2nhIBEborOM+MQ/UlMx8dFQWNPuJ1JPA/JU2WdNQjYorRXS88UhvfflsI/5lMTDOGwer9tVA03o/0xyusRTIp/JgjBkGr/uoqu75otMSFVs4pMjFKnP4IK9eP42m4AuGS7Ge1CUWmkuunZy/euuM6i8hTjEboFMaaA=
Message-ID: <7f45d9390602071541n65693ae5m7428d59dedcd5ae5@mail.gmail.com>
Date: Tue, 7 Feb 2006 16:41:16 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Elo touch panel
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060207081415.GA6731@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390602061830k6b984ban6fb302a3089cac6c@mail.gmail.com>
	 <20060207081415.GA6731@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Mon, Feb 06, 2006 at 07:30:26PM -0700, Shaun Jackman wrote:
...
> > I then run...
> >       $ inputattach -elo /dev/ttyS3
> > .. at which point dmesg says...
> >       serio: Serial port ttyS3
> > but it never gives a message indicating that the Elo driver has been
> > attached to ttyS3. Is there anything else I must configure?
>
> Try to look at /proc/bus/input/devices. The elo_connect() function
> should get called at the point the port is created. Unfortunately, I
> never could test this driver, because I don't have any touchscreens
> anymore (ever had one and it broke when I was moving). So there may be
> problems in the driver. But I believe others had some success running
> it.
>
> Looking at the driver, one will probably need to set the panel type in
> inputattach ...

There's a bug in inputattach. The SERIO_RS232 constant is completely
mucking the bits that specify the protocol.

--- inputattach.c-      2006-02-07 14:37:04.000000000 -0700
+++ inputattach.c       2006-02-07 16:22:07.000000000 -0700
@@ -455,7 +455,7 @@
                return 1;
        }

-       devt = SERIO_RS232 | input_types[type].type | (id << 8) | (extra << 16);
+       devt = input_types[type].type | (id << 8) | (extra << 16);

        if(ioctl(fd, SPIOCSTYPE, &devt)) {
                fprintf(stderr, "inputattach: can't set device type\n");

Cheers,
Shaun

APPENDIX A

You probably know this better than I do, but the .type above is
misnamed. It should really be .proto. It's impossible, as far as I can
tell, to specify the type (like SERIO_RS232) with a SPIOCSTYPE call.
