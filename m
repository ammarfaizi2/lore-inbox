Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTLNBop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 20:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbTLNBop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 20:44:45 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:2036 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265326AbTLNBog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 20:44:36 -0500
Date: Sat, 13 Dec 2003 17:44:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More questions about 2.6 /proc/meminfo was: (Mem: and Swap: lines in /proc/meminfo)
Message-ID: <20031214014429.GB1769@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031213032330.GA1769@matchmail.com> <Pine.LNX.4.44.0312131010400.26386-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312131010400.26386-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 13, 2003 at 12:54:19PM -0500, Rik van Riel wrote:
> On Fri, 12 Dec 2003, Mike Fedyk wrote:
> 
> > VmallocUsed is being reported in /proc/meminfo in 2.6 now.
> > 
> > Is VmallocUsed contained within any of the other memory reported below?
> 
> No.

OK, thanks.

> 
> > How can I get VmallocUsed from userspace in earlier kernels (2.[024])?
> 
> You can't.

OK, 2.6 only then...

> 
> > And the same questions with PageTables too. :)
> 
> Same answers ;)
> 
> Maybe I should send marcelo a patch to export the PageTables
> number in /proc somewhere ?

Yes!  Please do.  /proc/meminfo hopefully. :)

> > Are Dirty: and Writeback: counted in Inactive: or are they seperate?
> 
> They're unrelated statistics to active/inactive and will
> overlap with active/inactive.

Do they count anonymous memory, or are they strictly dirty/writeback
pagecache?

> 
> > Does Mapped: include all files mmap()ed, or only the executable ones?
> 
> Mapped: includes all mmap()ed pages, regardless of executable
> status.

Is mmap() always pagecache backed, or can it be backed with anonymous
memory?  IE, can I subtract mapped from pagecache?

I have this excerpt from a perl script (attached) that feeds data into lrrd,
a rrd-tool based graphing system.

"apps.value" is basically everything that's not counted in /proc/meminfo
(except for free, of course), and on 2.4 and below, it ends up showing a
larger number than should be correct, since pagetables, and several other
types of memory overhead are not reported.

print "apps.value ", $mems{MemTotal}-$mems{MemFree}-$mems{Buffers}-$mems{Cached}-$mems{Slab}, "\n";
print "free.value ", $mems{MemFree}, "\n";
print "buffers.value ", $mems{Buffers}, "\n";
print "cached.value ", $mems{Cached}, "\n";
print "swap.value ", $mems{SwapTotal}-$mems{SwapFree}, "\n";
print "slab.value ", $mems{Slab}, "\n";

check out http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=223346 for one of
the enhancements I'm making to the graphs.

I'd love to find a more accurate way to get the amount of memory used for
apps, short of reading the output of ps and doing calculations on RSS,
VIRTUAL, and SHARED...

Thanks,

Mike

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=memory

#!/usr/bin/perl -w
#
# Plugin to monitor memory usage.
#
# Slab cache memory checking added by Mike Fedyk
#
# Parameters:
#
# 	config   (required)
# 	autoconf (optional - only used by lrrd-config)
#
# Magic markers (optional - only used by lrrd-config and some
# installation scripts):
#%# family=auto
#%# capabilities=autoconf


if ($ARGV[0] and $ARGV[0] eq "autoconf")
{
	if (-r "/proc/meminfo" && -r "/proc/slabinfo")
	{
		print "yes\n";
		exit 0;
	}
	else
	{
		print "no (/proc/meminfo or /proc/slabinfo) found\n";
		exit 1;
	}
}

my %mems;
&fetch_meminfo;

if ($ARGV[0] and $ARGV[0] eq "config")
{
	print "graph_args --base 1024 -l 0 --vertical-label Bytes --upper-limit ", $mems{'MemTotal'}, "\n";
	print "graph_title Memory usage\n";
	print "graph_order apps slab swap_cache cached buffers free swap\n";
	print "apps.label apps\n";
	print "apps.draw AREA\n";
	print "buffers.label buffers\n";
	print "buffers.draw STACK\n";
	print "slab.label slab_cache\n";
	print "slab.draw STACK\n";
	print "swap.label swap\n";
	print "swap.draw STACK\n";
	print "cached.label cache\n";
	print "cached.draw STACK\n";
	print "free.label unused\n";
	print "free.draw STACK\n";
	if (exists $mems{'SwapCached'})
	{
		print "swap_cache.label swap_cache\n";
		print "swap_cache.draw STACK\n";
	}
	if (exists $mems{'Committed_AS'})
	{
		print "committed.label committed\n";
		print "committed.draw LINE2\n";
		print "committed.warn ", ($mems{SwapTotal}+$mems{MemTotal})*1024, "\n";
	}
	exit 0;
}

print "apps.value ", $mems{MemTotal}-$mems{MemFree}-$mems{Buffers}-$mems{Cached}-$mems{Slab}, "\n";
print "free.value ", $mems{MemFree}, "\n";
print "buffers.value ", $mems{Buffers}, "\n";
print "cached.value ", $mems{Cached}, "\n";
print "swap.value ", $mems{SwapTotal}-$mems{SwapFree}, "\n";
print "slab.value ", $mems{Slab}, "\n";

if (exists $mems{'SwapCached'})
{
	print "swap_cache.value ", $mems{SwapCached}, "\n";
}

if (exists $mems{'Committed_AS'})
{
	print "committed.value ", $mems{'Committed_AS'}, "\n";
}

sub fetch_meminfo
{
	my (@memline, @swapline);
	open (IN, "/proc/meminfo") || die "Could not open /proc/meminfo for reading: $!";
	while (<IN>)
	{
		if (/^(\w+):\s*(\d+)\s+kb/i)
		{
			$mems{$1} = $2 * 1024;
		}
		elsif (/^Mem:\s+(.+)$/)
		{
			@memline = split;
		}
		elsif (/^Swap:\s+(.+)$/)
		{
			@swapline = split;
		}
	}
	close (IN);
	if (!$mems{Slab})
	{
		$mems{Slab} = &fetch_slabinfo;
	}
	if (!$mems{MemTotal})
	{
		$mems{MemTotal} = $memline[1];
		$mems{MemFree} = $memline[3];
		$mems{Buffers} = $memline[5];
		$mems{Cached} = $memline[6];
		$mems{SwapTotal} = $swapline[1];
		$mems{SwapFree} = $swapline[3];
	}
}

sub fetch_slabinfo
{
	open (IN, "/proc/slabinfo") || die "Could not open /proc/slabinfo for reading: $!";
        my $tot_slab_pages = 0;
	while (<IN>)
	{
	    if (!/^slabinfo/)
	    {
		@slabinfo = split;
		$tot_slab_pages += $slabinfo[5];
	    }
	}
	close (IN);
        return $tot_slab_pages * 4096 
}

--6TrnltStXW4iwmi0--
