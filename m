Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWBNH2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWBNH2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWBNH2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:28:51 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31968 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750962AbWBNH2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:28:50 -0500
Date: Tue, 14 Feb 2006 09:28:30 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
In-Reply-To: <43F0B8FC.6020605@cfl.rr.com>
Message-ID: <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
References: <m3lkwg4f25.fsf@telia.com> <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
 <43F0B8FC.6020605@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Phillip Susi wrote:
> Could you be more specific about what test cases fail?  It worked fine for me
> so far.

I don't haven an UDF partition to test on so I am only reading the code. 
With your patch, every time an in-memory inode has the same uid/gid as the 
one you passed as mount option, the id on disk will become -1, no? So for 
example, doing chown 100 for a file writes -1 to disk if you passed 100 
as uid mount option. Am I missing something here?

On Mon, 13 Feb 2006, Phillip Susi wrote:
> > I think the semantics you want is: "if uid/gid is invalid on disk,
> > leave it that way unless we explicitly change it via chown; otherwise
> > we can always overwrite it." Hmm?
> 
> No, the semantics is if the uid/gid on disk is invalid, then use the id
> specified in the mount options.  That was the case before, however when you
> created new files or chowned files to you ( and you gave your id in the mount
> options ), an id of 0 was written to disk instead.  Now -1 is written, which
> when read, is mapped back to your id specified in the mount options. 

Yes, I agree that the current code is broken. I was talking about what the 
semantics should be and that your patch doesn't quite get us there. Do you 
disagree with that? The UDF specification I am looking at [1] says that -1 
is used by operating systems that do not support uid/gid to denote an 
invalid id (although ECMA-167 doesn't seem to have such rule), which is  
why I think it's an bad idea for Linux to ever write it on disk. Instead, 
we should always write the proper id on disk unless it was invalid in the 
first place and we did not explicity change it (via chown, for example).

  1. http://www.osta.org/specs/pdf/udf260.pdf

				Pekka
