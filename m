Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSLMJu0>; Fri, 13 Dec 2002 04:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSLMJu0>; Fri, 13 Dec 2002 04:50:26 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:43278 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261839AbSLMJuX>; Fri, 13 Dec 2002 04:50:23 -0500
Date: Fri, 13 Dec 2002 09:58:06 +0000
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, lvm-devel@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: dmfs for 2.5.51
Message-ID: <20021213095806.GC1117@reti>
References: <20021213012618.GH23509@kroah.com> <3DF93CC9.979CA988@digeo.com> <20021213052551.GB25099@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213052551.GB25099@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 09:25:51PM -0800, Greg KH wrote:
> On Thu, Dec 12, 2002 at 05:50:01PM -0800, Andrew Morton wrote:
> > hm.  The whole thing seems hokey to me.  Not sure why.
> 
> I agree.  It doesn't feel right.  I mean, doing a mkdir(1) to create a
> device, which causes files to be created automagically in that
> directory?  Something needs to change here, and I proposed a single file
> to write to that creates the device, but was shot down by the author.

Greg, I didn't mean to make it sound like I was shooting you down, I
just said that we'd leave it as it was for now.  Having written the
code I wanted a bit more feedback.  When I started writing the fs
interface a couple of people expressed concerns that I should try and
map things properly onto fs semantics and not just create a single
file.  Given Andrews comment I guess I haven't done a good job.  Could
you flesh out your single file idea a bit more please, there's a lot
of functionality to shoe horn in there.

> > > ...
> > > +  echo -e "0 56 linear /dev/hda3 0\n56 102344 linear /dev/hda4 0" > table
> > 
> > Maybe this is why.
> 
> Heh, yeah, welcome to parsers in the kernel :)
> But the dm code today does much the same thing with ioctls, passing a
> string down to the loaded modules below it.  So there is a bit of
> president.  Even if it is ugly :)

y, the dm targets have always accepted their arguments as ascii
strings.  So the file system interface just adds code to split the
input into lines, and then sscanf the first three elements of the line
- this is probably less code than the marshalling of binary data that
is done in the ioctl interface.

I see the fact that we're using ascii data as being the big advantage
of the fs interface, which neccessarily means doing a small amount of
parsing in kernel.  You can't have things both ways.

> > > ...
> > > +static struct page *find_page(struct dmfs_file *f, loff_t len, int fill)
> > 
> > This is called under spinlock.
> > 
> > > ...
> > > +                       void *addr = (void *) __get_free_page(GFP_KERNEL);
> > 
> > whoops.

My fault :(

> Nice catch.  I'm not sure that the find_page(), __io() and friends
> functions are really needed at all.

It would be nice to get rid of them, what shall we replace them with ?

- Joe
