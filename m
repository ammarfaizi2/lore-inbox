Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWBMHlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWBMHlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWBMHlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:41:05 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6675 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751194AbWBMHlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:41:04 -0500
Date: Mon, 13 Feb 2006 08:37:46 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linda Walsh <lkml@tlinx.org>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060213073746.GG11380@w.ods.org>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org> <20060213000803.GY27946@ftp.linux.org.uk> <43EFD8BF.1040205@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EFD8BF.1040205@tlinx.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 04:54:23PM -0800, Linda Walsh wrote:
> Al Viro wrote:
> >On Sun, Feb 12, 2006 at 02:54:33PM -0800, Linda Walsh wrote:
> >  
> >>Al Viro wrote:
> >>    
> >>>Care to RTFS? I mean, really - at least to the point of seeing what's
> >>>involved in that recursion.
> >>> 
> >>>      
> >>Hmmm...that's where I got the original parameter numbers, but
> >>I see it's not so straightforward.  I tried a limit of
> >>40, but I quickly get an OS hang when trying to reference a
> >>13th link.  Twelve works at the limit, but would take more testing
> >>to find out the bottleneck.
> >>    
> >
> >Sigh...  12 works at the limit on your particular config, filesystems
> >being used and syscall being issued (hint: amount of stuff on stack
> >before we enter mutual recursion varies; so does the amount of stuff
> >on stack we get from function that are not part of mutual recursion,
> >but are called from the damn thing).
> >  
> ---
>    Yeah, I sorta figured that.  Is there any easier way to
> remove the recursion?  I dunno about you, but I was always taught
> that recursion, while elegant, was not always the most efficient in
> terms of time and space requirements and one could get similar
> functionality using iteration and a stack.

I don't know exactly why recursion is used to follow symlinks,
which at first thought seems like it could be iterated, but
I've not checked the code, there certainly are specific reasons
for this. However, there's often an alternative to recursion, it
consists in implementing a local stack onto the stack. I mean,
when you need recursion, it is because you want to be able to
get back to where you were previously (eg: try another branch
in a tree). Recursing through functions has a high cost in
terms of memory because many things get saved multiple times,
while you will often only need a few pointers and a recursion
level.

I have already implemented this in a few programs and it's very
easy, although I don't know how it would be with the symlink code :

foobar() {
  void *stack[MAXDEPTH];
  void *ptr;
  int  level;

  level = 0;
  ...
recurse:
  if (level >= MAXDEPTH)
    return -ELOOP;

  /* this level's work before the recursive call */
  ...
  ptr = some_useful_pointer();
  printf("before: ptr=%p, level=%d\n", ptr, level);
  ...
  if (need_to_recurse) {
    stack[level++] = ptr;
    goto recurse;
  }
after_return:
  /* this level's work after the return */
  ...
  printf("after: ptr=%p, level=%d\n", ptr, level);
  ...
  /* return to outer level */
  if (level > 0) {
    ptr = stack[--level];
    goto after_return;
  }
  ...
  /* end of the work for level 0 */
}

Saving paths components this way is easy too, with the full name copied
only once in memory, and with one byte per recursion level :

  char path[MAXPATHLEN];   /* <= 255 */
  __uint8_t pathlen[MAXDEPTH];
  char *path_end;

  path_end = path;
  ...
  snprintf(path_end, path+MAXPATHLEN-path_end, "foobar/");
  ...
  if (need_to_recurse) {
    pathlen[level++] = path_end - path;
    goto recurse;
  }
  ...
  /* return to outer level */
  if (level > 0) {
    path_end = path + pathlen[--level];
    *path_end = '\0';
    goto after_return;
  }
 
>    The GNU libraries _seem_ to indicate a max of 20 links supported
> there.  Googling around, I see I'm not the first person to be surprised
> by the low limit.  I don't recall running into such a limit on any
> other Unixes, though I'm sure they had some limit.
> 
>    It can be useful for creating a shadow file-system where only
> root needs to point to a "target source", and the "symlink" overlay
> lies over the top of any real, underlying file.

I've already encountered such setups in which I was worried that they
might break under some 2.6 kernels.

>    Why can't things just be easy sometimes...:-/

Probably because having both performance and maintainability often
implies a tradeoff between easy and ugly, and the maintainer's job
is to find the best tradeoff.

> Linda

Regards,
Willy

