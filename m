Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUKTLkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUKTLkA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUKTLkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:40:00 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:38486 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261703AbUKTLjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:39:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i8T65fgB90TucKQppUApbkCFl5uyS9trmU1r4gArOFwr4Jd9YtLdPiRMomgYK+w0l6RHkUT8iUSNadseegxE94aJO6SwVOnG/8NNCrj0NhykUZmGGB5VBbaEfgNoqNrgZRSx+g7Ayey1XP7iJ/XMMaowky2orZ67zTf6psAt0z0=
Message-ID: <69304d110411200339b29177e@mail.gmail.com>
Date: Sat, 20 Nov 2004 12:39:08 +0100
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
Subject: Re: on the concept of COW
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1100947100.4038.41.camel@myLinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1100947100.4038.41.camel@myLinux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2004 16:08:21 +0530, Jagadeesh Bhaskar P
<jbhaskar@hclinsys.com> wrote:
> Hi,
> 
>  When a process forks, every resource of the parent, including the
> virtual memory is copied to the child process. The copying of VM uses
> copy-on-write(COW). I know that COW comes when a write request comes,
> and then the copy is made. Now my query follows:
> 
> How will the copy be distributed. Whether giving the child process a new
> copy of VM be permanent or whether they will be merged anywhere? And

Permanent. Re-merging (or rather call it UN-COWING ;) is not
considered necesary.

> shouldn't the operations/updations by one process be visible to the
> other which inherited the copy of the same VM?

No, because by default all allocations are marked as private for each
process. The fact is, the original UNIX did not do COW, but did copy
the whole process memory and handed this copy to the child process.

> How can this work? Can someone please help me on this regard?

If you want to share a mapping, the easiest way is to:

1. Create a temp file on /tmp with the size you need.
2. mmap the file, which will get the file contents into your
addressing space. Remeber to ask for shared mapping.
3. Fork.
4. Now both processes have an mmaped file with shared mapping.
Anything written by one is seen by the other, since they use the same
backing space. The contents are also visible by doing a cat on the
shared temporary file (this is great for debugging :).

You may not want to keep the file around. You can delete the file just
after having opened it, so that it's not visible on the filesystem. It
will just keep using the space until you exit all processes which were
using the file.

-- 
Greetz, Antonio Vargas aka winden of network

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
