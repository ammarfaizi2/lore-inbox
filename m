Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRAHRzY>; Mon, 8 Jan 2001 12:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135512AbRAHRzQ>; Mon, 8 Jan 2001 12:55:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32118 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133101AbRAHRzJ>; Mon, 8 Jan 2001 12:55:09 -0500
Date: Mon, 8 Jan 2001 18:55:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108185518.G27646@athlon.random>
In-Reply-To: <20010108180857.A26776@athlon.random> <Pine.LNX.4.30.0101081230160.15703-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101081230160.15703-100000@viper.haque.net>; from mhaque@haque.net on Mon, Jan 08, 2001 at 12:31:29PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:31:29PM -0500, Mohammad A. Haque wrote:
> I fail to see why this is useful. you can't do anything in the directory
> afterwards.
> 
> bash# mkdir foobar
> bash# cd foobar/
> bash# ls
> bash# rmdir .
> bash# touch foooooo
> touch: foooooo: Operation not permitted
> bash# ls
> 
> Whats the point of it?

To type less characters. I'll show you the code that is failing:

def binutils():
	print 'Checking out binutils'
	sys.stdout.flush()
	os.chdir(binutils_dir)
	if os.system('%s update -A -d -P' % CVS):
		print 'failed binutils checkout'
		sys.exit(1)

	print 'Compiling and installing binutils'
	sys.stdout.flush()
	os.chdir('..')
	binutils_build = 'binutils-build-%s' % BUILD
	os.mkdir(binutils_build)
	os.chdir(binutils_build)
	if os.system('../binutils/configure --target=x86_64-unknown-linux --prefix=%s && make && make install' % install_dir):
		print 'failed binutils compile'
		sys.exit(1)
	shutil.rmtree(".")

Why should I write:

	os.chdir("..")
	shutil.rmtree(binutils_build)

when I can simply write:

	shutil.rmtree(".")

I know in the above case I really could avoid the os.chdir(binutils_build) and
to use `cd %s; ...` % (binutils_dir, install_dir) and probably
it wouldn't make much difference, but the above looks simpler and I may have
other things to run while inside the binutils_dir too so it could make lots of
sense to os.chdir there as I just did.

To workaround this misfeature I can simply implement a derivative class of
shutil in my robot and to wrap the rmtree method to emulate the 2.2.x behaviour
in userspace, but I think the old behaviour was more flexible (it was also
showing how much our dcache is powerful) and I still don't see why it's been
removed.  Maybe it was to remove a branch from a fast path? (if so I don't
think it was a good idea, there are many more overhead things that matters more
and that aren't even visible to userspace)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
