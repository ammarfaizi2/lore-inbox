Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292244AbSBBHcB>; Sat, 2 Feb 2002 02:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292245AbSBBHbw>; Sat, 2 Feb 2002 02:31:52 -0500
Received: from tapu.f00f.org ([63.108.153.39]:49597 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S292244AbSBBHbm>;
	Sat, 2 Feb 2002 02:31:42 -0500
Date: Fri, 1 Feb 2002 23:30:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202073020.GA7014@tapu.f00f.org>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020202021242.GA6770@tapu.f00f.org> <3C5B56A4.B762948F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5B56A4.B762948F@zip.com.au>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 07:01:56PM -0800, Andrew Morton wrote:

    We can.  Graham Stoney had all this going against 2.2.  See

    http://www.google.com/search?q=stoney+ffunction-sections&hl=en&start=10&sa=N
    http://www.cs.helsinki.fi/linux/linux-kernel/Year-2000/2000-29/0415.html

This puts every function it's own section.  That seems not only
cumbersome to me, but also a little complex.  That said,  it may be a
good way if run every now and then to detect when cruft starts to
accumulate for any given .config and allow people to tweak things for
smaller kernels.

Is there no way to write something like:

--snip-- foo.c --snip--
void
blem()
{
}

void
bar()
{
    blem();
    return 0;
}

int foo()
{
    return 1;
}

int main(...)
{
    return foo();
}
--snip-- foo.c --snip--

compile and link it, have the linker know main or some part of crt0 is
special, build a graph of the final ELF object, see that bar and blem
are not connected to 'main' and discard them?

I'm pretty sure (but not 100% certain) that oher compilers can do
this, maybe someone can test on other platforms?

A really smart linker (if given enough compiler help) could build a
directional graph and still remove this code even if blem called foo.


Perhaps I'm making something that's extremely complex sound simple,
but it doesn't seem to me that this should be that complex...  maybe
someone more farmiliar with binutils and/or gcc can comment and tell
me why I'm being a fool :)

    The kernel doesn't link when you compile with -fno-inline because
    of all the `extern inline' qualifiers.  These need to be converted
    to `static inline'.  Jim Houston has a script which does this.

Semantically, in gcc land, someone explain the difference between:

     inline

     extern inline

     static inline

please?


My tests seem to indicte:

  inline creates an non-inline functions.  Simple tests failed to have
  this function inlined at all

  static inline and extern inline functions can and will be inlined depending
  on optimization level

  extern inline doesn't product a non-inlined function (even if it is
  referenced) and hence barfs if you don't compile with optimisations
  for my simple test

Now, I wonder

  why 'inline' for me, never inlines?

  is there a way to force inlining of a function?

  are non-inlined functions ever called when optimizations are
  enabled?




Thanks,


  --cw
