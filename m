Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315264AbSEFXyn>; Mon, 6 May 2002 19:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSEFXym>; Mon, 6 May 2002 19:54:42 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:8461 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315264AbSEFXyl>;
	Mon, 6 May 2002 19:54:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Mon, 06 May 2002 13:33:18 +0200."
             <Pine.LNX.4.33.0205061129440.19054-100000@cola.enlightnet.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 May 2002 09:54:29 +1000
Message-ID: <18740.1020729269@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002 13:33:18 +0200 (CEST), 
Urban Widmark <urban@teststation.com> wrote:
>On Mon, 6 May 2002, Keith Owens wrote:
>
>> >being able to build over NFS or having stricter integrity checks. I just
>> >don't get the faster bit, but maybe that's just me.
>> 
>> You are not comparing like with like.  Much of your speed difference
>> from kbuild 2.4 to 2.5 is because you have omitted the make dep time.
>> kbuild 2.5 does not have a seperate make dep pass.  Instead it checks
>> the dependencies every time, during phase4.
>
>make dep isn't part of a module rebuild given the constriants I work
>under, the changes are local to the module (which they are).
>
>In my world make dep is only relevant for the first build, and the
>times I mentioned for the full build includes a dependency build.
>(I know the presentation of that part was crap ... but so was the
> measurements :)

kbuild 2.4 defaults to doing a (possibly) inaccurate build after
changes.  You have to manually run extra commands to ensure that kbuild
2.4 does an accurate build.  If you believe that your change has not
changed the build dependency graph, it _may_ be safe to omit the extra
commands.

kbuild 2.5 defaults to always doing an accurate build, no matter what
has changed.  You have to specify a command line option to bypass the
full processing and make it (possibly) inaccurate.  If you believe that
your change has not changed the build dependency graph, it _may_ be
safe to specify the command line option.

You have to specify a command line option on kbuild 2.5, to get the
same behaviour that kbuild 2.4 does by default.  It comes down to what
should the default be for a build?

* kbuild 2.4 defaults to assuming that nobody ever makes misteaks.
* kbuild 2.5 defaults to assuming that mistakes occur.

This is almost a religious argument, should the build be unsafe and
assume that everybody is an expert or should the build be safe and
provide facilities for experts to override it?  I am a true believer in
"the build must be safe" model.

>What you are saying is that I should never do:
>make modules
>
>but always:
>make dep && make bzImage modules
>
>Ok, then I see what you meant by kbuild-2.5 being faster.

That is the only way to ensure an accurate build on kbuild 2.4.  Yes,
if you know that your change has no side effects then you can omit make
dep bzImage.  The problem is that many people automatically omit the
extra commands, without considering the implications.

>Documentation/kbuild/commands.txt (2.4.18 kernel, don't have anything more
>recent at hand) has a section on make dep that says I only have to run it
>once after the first time I configure the kernel. Maybe that is where I
>picked up that habit.

The documentation is correct, but incomplete.  It is correct for an end
user kernel build, i.e. for people who do not change the code or apply
patches, they just configure the kernel and build it.  It is incomplete
for developers and for anybody who gets a patch and applies it.

You need to run make dep after any change that affects the build
dependency graph.  Add or delete #include in a source, add or delete a
source, add or delete a config option and you must run make dep to
ensure that the changes rebuild what is required.  Modversions are even
worse, after any change that might affect an exported symbol or
structure, you must make mrproper (not dep) to calculate and apply the
new hashes to the entire kernel.

As more and more people apply patches (how many variants of the kernel
tree are there now?), more and more people are forgetting to run make
dep and are building incomplete kernels.

The default for kernel build must be a safe and accurate build.

