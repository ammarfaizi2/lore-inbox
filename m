Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317990AbSFSUB4>; Wed, 19 Jun 2002 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317991AbSFSUB4>; Wed, 19 Jun 2002 16:01:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30405 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317990AbSFSUBz>;
	Wed, 19 Jun 2002 16:01:55 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Jun 2002 22:01:09 +0200 (MEST)
Message-Id: <UTC200206192001.g5JK19C03065.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, torvalds@transmeta.com
Subject: Re: [PATCH+discussion] symlink recursion
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       phillips@bonn-fries.net, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But trying to sell this thing to me as a "recursion is evil"

I realize you probably missed the history. There was a discussion
about large stack variables found by Checker, and how Checker
might have difficulties getting the max stack right in the presence
of this recursion.

I remarked that it is trivial to remove the recursion, should anyone
be interested in that, but Al called such claims false and wrong,
so I did half of the work (removing the filesystems from the loop)
three days ago, and Al said that it was nothing yet, actually
removing the recursion would be hell. So I removed the recursion
yesterday evening. A demo project.

(And you were cc'ed only because I happened to come across what
I think is a refcounting buglet in the present code.)

Have not heard from Al yet, but my secret hope is that he'll soon
come back and tell me that my code is ugly and contains seventeen
bugs but that he has done it right with elegant, fast and maintainable
code.

In the meantime, no, this was not a patch submission, it was for
discussion and because Al wanted to see actual code.



> Yes. But did you look at the stack frames of those things? It's something
> like 16 bytes for ext2_follow_link (it just calls directly back to the VFS
> layer), 20 bytes for vfs_follow_link(), and 56 for link_path_walk.
> Oh, and I think the actual ->follow_link pushes 8 bytes of arguments.

So 100 bytes for ext2. The code I showed uses one struct for each
recursion level, where the struct is

struct link_work {
        const char *name;
        struct path next, pinned;
        unsigned int flags;
        struct page *page_to_free;
        const char *link_to_free;
        struct link_work *lw_next;
};

which looks like 36 bytes, independent of the filesystem.
If one wants to optimize, both link_to_free and lw_next
are superfluous and one can come down to 28 bytes.

That again means that a version that allocates ten such structs
on the stack at the start (for speed, so as to avoid a malloc)
would allow a recursion 10 deep and use ~300 bytes of stack space.
As I presented it yesterday, the struct is kmalloced so uses
no stack space.

> So doing a recursion 5 deep is ~500 bytes of stack space.

> But hey, guys, if you want to linearize the recursion, I'm easily swayed
> by numbers. I've actually done the numbers for stack usage (exactly
> because I worried about it some time ago), and I don't worry too much
> about that number. I also don't worry about the number "5", simply because
> I don't think I've _ever_ gotten a complaint about it that I remember.

> But there are other numbers, like performance (sometimes linearizing
> recursion loses, sometimes it wins), or somebody doing the math on ia-64
> and showing that the 100 bytes/level on x86 is actually more like 2kB on
> ia-64 and totally unacceptable.

I do not expect any measurable changes in timing.
And if even a single lost cycle is inadmissable, this could be unrolled
once so that new code is seen only during symlink resolution.

But I do not want to push this at all. It is something we might do.
Or we could do half and only remove the recursion through the filesystems.

Let us wait and see what Al says.

Andries
