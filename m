Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSKEVdn>; Tue, 5 Nov 2002 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSKEVdm>; Tue, 5 Nov 2002 16:33:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:21265 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264936AbSKEVcp>;
	Tue, 5 Nov 2002 16:32:45 -0500
Date: Tue, 5 Nov 2002 16:39:18 -0500 (EST)
Message-Id: <200211052139.gA5LdIc373506@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, jw@pegasys.ws, wa@almesberger.net, rml@tech9.net,
       andersen@codepoet.org, woofwoof@hathway.com
Subject: Re: ps performance sucks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First of all, sorry to break the threading. I didn't get
a Cc: and the web archives drop most email headers. I'm
going to respond to everyone in a big blob w/o attributions.

> Clearly ps could do with a cleanup. There is no reason to
> read environ if it wasn't asked for. Deciding which files
> are needed based on the command line options would be a

Done. You should be using procps-3.0.5 now. If you're not,
an upgrade is called for. http://procps.sf.net/

(tough luck if you're using some other ps)

Nothing that parses the crap in /proc will ever be fast though.
There's a patch for Linux 2.4.0 that some people might like:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0104.2/1720.html

> Strace it - IIRC it does 5 opens per PID. Vomit.

Nope, it does 2. Perhaps you're not running procps 3 yet?
http://procps.sf.net/

Of course if you do something like "ps ev" you need all 5.

> I'm thinking that ps, top and company are good reasons to
> make an exception of one value per file in proc. Clearly
> open+read+close of 3-5 "files" each extracting data from
> task_struct isn't more efficient than one "file" that
> generates the needed data one field per line.

There are several ways to attack this.

First of all, implement an open_read_close() syscall. Duh.
I expect Hans Reiser would be delighted too. Maybe return
a file descriptor if the file was too big or it blocked.
Maybe provide some basic stat data atomically with the call.

For per-task proc files, one file per kernel lock seems sane.
I haven't looked at how many that would be, and of course it
varies by kernel. So maybe it ends up not being exact; that's OK.

> I think it's pretty trivial to make /proc/<pid>/psinfo, which
> dumps the garbage from all five files in one place. Which makes
> it 5 times better, but it still sucks.

Well, not all the garbage! It'd be nice to have the popular
stuff in a file similar to /proc/*/stat. That would be what ps
needs to support these options: -f -l -F l u v j -j -ly -lc
plus "top". (not counting the process name or args though)

> You could take a more radical approach. Since the goal of such
> a psinfo file would be to accelerate access to information
> that's already available elsewhere, you can do away with many
> of the niceties of procfs, e.g.
>
>  - no need to be human-readable (e.g. binary or hex dump may
>    make sense in this case)

As long as you expand everything to the biggest data type that
could ever be used, binary is wonderful. Make the ABI be 64-bit
for almost everything, with proper alignment of course. Somebody
slap the person who put a 32-bit ino_t in the latest stat syscall.

> First write says "pid,comm". Internally, this gets translated
> to 0x8c+0x04, 0x2ee+0x10 (offset+length). Next read returns
> "pid 4,comm 16" (include the name, so you can indicate fields
> the kernel doesn't recognize). Then, kmalloc 20*tasks bytes,
> lock, copy the fields from struct task_struct, unlock, let the
> stuff be read by user space, kfree. Adjacent fields can be
> optimized to single byte strings at setup time.

If you're going to do that, then specify stuff via the filename:
/proc/12345/hack/80basic,20pids,20uids,40argv,4tty,4stat

Not that I care for dealing with the above!

>> sgid country
>> * real killer: you think Albert would fail to produce equally
>> crappy code and equally crappy behaviour? Yeah, right.
>
> Well I think Rik and I can handle it in our tree :)

You guys can't even get BSD process selection right.

If necessary I could fix a few spots needed for setgid usage.
I'd rather not need to do so, because then yet another chunk
of non-kernel code is making security decisions.

> * device is not network-transparent - even in principle

ROTFL. What a fantasy. You damn well know /proc isn't either.
If you can hack /proc to be exportable, you can damn well do
the same for a device file. You won't be using NFS for this.
I think Mosix already has a shared /proc anyway; an ioctl() is
a simple matter of writing a little ugly code.

> And i'd still keep environ seperate. I'm inclined to think
> ps should never have presented it in the first place.
> This is the direction i (for what it's worth) favor.

Yeah, well that's BSD compatibility for you. Printing the
environment might actually be useful if you could pick just
the fields you wanted:  ps -eo pid,stat,.DISPLAY,comm

Useful? Like that notation?

> Well if we want to be gross and efficient, we could just compile
> a kmem-diving dynamic library with every kernel compile and stick
> it in /boot or somewhere. Mildly less extreme is a flat index file
> for the data you need a la System.map. Then just open /dev/kmem
> and grab what you want. Walking the tasklist with no locking would
> be an interesting challenge, but probably not insurmountable.
> That's how things like ps always used to work IIRC.

Yep, that's gross and efficient for sure. The dynamic library idea
fixes a major problem; BSD "top" is always breaking due to kernel
differences on Solaris and FreeBSD.
