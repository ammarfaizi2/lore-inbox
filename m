Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVLMP3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVLMP3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVLMP3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:29:40 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:55386 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965001AbVLMP3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:29:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SyvSmUZzXWYGYDqxyrShuh71B1ULC42Cot67WC/kd1aAQhooV1vkcMrJhG2C5QAGPvUuyCxDSoL54rv+hez8cOAuOjCvtgpjIHIFL3cUG1LGtL4z+8aEFw8mzCkG5GUfyAXVSUjNhpptCQfApD71RDL90Zkpa8DVy1cbymmgsIM=
Message-ID: <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
Date: Tue, 13 Dec 2005 17:29:28 +0200
From: Shem Multinymous <multinymous@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tp_smapi conflict with IDE, hdaps
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>,
       Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
In-Reply-To: <1134486203.11732.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-12-13 at 16:35 +0200, Shem Multinymous wrote:
> > Evidently, the SMAPI BIOS sends some ATA command to the drive. If the
> > kernel is accessing the drive at the same time (e.g., an ongoing "cat
> > /dev/scd0"), the machine hangs.
>
> You will need to find out the command.

Sure, that would be ideal. But how? You can't get that from the SMAPI
BIOS - it's totally opaque. You just write a constant to port 0xB2,
which triggers an SMI; the BIOS merrily does its thing in SMM and
returns; you see the final results in the CPU registers.

> There are standard commands for this so they ought to work. If not we need to
> know why, who makes the drive used etc

ThinkPad T43 BIOS 1.24, Hitahi HTS726060M9AT00 firmware MH4OA6GA. No
idea how to proceed beyond this.

The thing is, there *is* a working interface, which is also used by
the Windows drivers...


> Trying to arbitrate libata access with unknown bios behaviour isn't going to have a
> sane resolution.

Why? BTW, isn't this similar to the queue freeze functionality needed
by the disk park part of the ThinkPad HDAPS?


> > with the recently added HDAPS accelerometer driver. Both drivers read
> > their data from the same ports (0x1604-0x161F), which implement a
> > query-reponse transaction interface, so both drivers talking to the
> > hardware simultaneously will wreak havoc. Some synchronization is
> > needed, and a way to address the request_region conflict.
> >
> > What is standard procedure for resolving such conflicts?
>
> You probably want a low level driver that just arbitrates the interface
> and implements the basic query/response transaction interface and
> locking and then is called by both HDAPS and your driver (and no doubt
> other future drivers talking to that controller). It can thene export
> the interface to both drivers.

We don't understand the controller interface sufficiently well to
fully abstract it (no specs, and the two conflicting drivers do things
somewhat differently), so for now the low-level driver may only handle
locking... Is there an easier way to just share a mutex?

Anyway, can you point out a minimal example (or two) of such low-level
drivers in the current kernel, so I can imitate the recommended
interface convention?

  Shem
