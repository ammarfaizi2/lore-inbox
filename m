Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSCVH6W>; Fri, 22 Mar 2002 02:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293242AbSCVH6L>; Fri, 22 Mar 2002 02:58:11 -0500
Received: from mario.gams.at ([194.42.96.10]:18246 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S293204AbSCVH6E>;
	Fri, 22 Mar 2002 02:58:04 -0500
Message-Id: <200203220758.IAA09819@merlin.gams.co.at>
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Organization: Maxxio Technologies
To: David Brown <dave@codewhore.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch, forward release() return values to the close() call
Date: Fri, 22 Mar 2002 08:58:02 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <3C999633.2060104@mandrakesoft.com> <20020321113201.A26882@codewhore.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Forgive me if I'm not completely understanding this, but isn't release()
> only called when the refcount of the file structure drops to zero? e.g.:
>
>   [18]Note that release isn't invoked every time a process calls close.
>   Whenever a file structure is shared (for example, after a fork or a
>   dup), release won't be invoked until all copies are closed. If you need
>   to flush pending data when any copy is closed, you should implement the
>   flush method.

Oh that might be, however in my case the device is exclusivly locked, so it 
doesn't matter that much, since there can be only one writer.

To explain what it actually is, it's a driver to program a LCA chip, an 
userspace opens the device, writes the program for the LCA, and closes the 
device. The driver itself can not understand the file format transmitted 
trough it, and has so no chance to know where the supposed end of stream is 
until the userspace closes the device. At close() it let's the LCA go, and 
looks if it's starting up, if so it has accpeted it's program, if not the 
file was not a valid image or the LCA might be damaged, and this error 
condition should be signaled.

Programming a LCA simply works then from the shell like in example this:
$> cp my-lca-image /dev/lca || echo "LCA failure :("

Where cp fails if the lca has not accepted it's image.

flush() can also be called in middle of stream, and is not a good indication 
for an end of stream. 

> > Your driver is buggy, if it thinks it can fail f_op->release.

If this is would be really (always) true, wouldn't it at least be better to 
have the release() prototype with a void return value?
