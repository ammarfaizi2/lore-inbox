Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSKHXnk>; Fri, 8 Nov 2002 18:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbSKHXnj>; Fri, 8 Nov 2002 18:43:39 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:7153 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263281AbSKHXnj>; Fri, 8 Nov 2002 18:43:39 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <aqhhft$19b$1@penguin.transmeta.com> 
References: <aqhhft$19b$1@penguin.transmeta.com>  <24305.1036795742@passion.cambridge.redhat.com> 
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: mmap(PROT_READ, MAP_SHARED) fails if !writepage. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Nov 2002 23:50:19 +0000
Message-ID: <25622.1036799419@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



torvalds@transmeta.com said:
>  This is broken. Since it has VM_MAYWRITE, a subsequent mprotect() may
> mark it writable, and you you went boom.

Er, we clear VM_MAYWRITE...

+               if (vma->vm_flags & VM_WRITE)
                        return -EINVAL;
+               else
+                       vma->vm_flags &= ~VM_MAYWRITE;

> If you really want a shared mapping, you'd better open with O_RDONLY,
> at which point the existing code should be perfectly happy and does
> the right thing. 

It's a read-only mapping. Whether it's shared or private is not relevant,
surely, since those affect only the behaviour if we write to it -- which we 
can't. 

I don't _really_ want a shared mapping; all I want is for the fsx-linux
stress test to run, and find interesting breakage on my file system to keep
me from getting bored (what are Friday nights for, after all?).

As shipped, fsx-linux uses PROT_READ, MAP_SHARED on its test file, which
definitely needs to be opened for write. For now, I've just changed it to
use MAP_PRIVATE. I'm just a bit concerned about having to change the test to
get it to work though, and don't see why a _readonly_ mmap should fail due 
to lack of writepage.

--
dwmw2


