Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311269AbSC1Amq>; Wed, 27 Mar 2002 19:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311242AbSC1Aml>; Wed, 27 Mar 2002 19:42:41 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:25872 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S311239AbSC1AmZ>; Wed, 27 Mar 2002 19:42:25 -0500
Date: Thu, 28 Mar 2002 00:42:21 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <3CA263EB.2576ED4A@zip.com.au>
Message-ID: <Pine.LNX.4.33.0203280034350.18231-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Andrew Morton wrote:

> >         tuning? single  ir      mx-ir   oltp    mixed-oltp
> >                 (sec)   (tps)   (sec)   (tps)   (sec)
> > ext3    bn      1285.32 65.98   1996.41 90.05   307.79
> > ext3-wb bn      1287.31 98.42   2149.38 125.13  236.02
> > ext3-jd bn      1306.90 72.07   1813.54 125.15  305.27
>
> Oh well.

Sometimes better, sometimes worse.  I'll kick another run
off tonight, to check that the numbers aren't too far off.

> It sounds like a useful and valid workload to optimise
> for.  So I'll take you up on the offer of those scripts,
> please.

My scripts are roughly the appended, and:

grep -E '(agg_simple|Bench|crossSe|Mixed|"Sin)' dbb-tuned.out | \
		sed 's/^crossSection/cS/'

I've been too lazy so far to automate the "make it into a
table" bit, particularly because I quite like watching the
results come in :)

Cheers,
Matthew.



#!perl -w
use strict;

my $PART = '/dev/sdb6';
my $FORCEOPTS = 'noatime';
my $DEFOPTS = undef;
my $DEBUG = 1;
my $DEBUGONLY = 0;

my @FSES = qw(jfs ext3 ext3-wb ext3-jd minix ext2);
my @DBS = qw(postgresql);

my @BENCHOPTS = qw(--datadir /home/matthew/dbbench/data-40mb --short);

my %filesystems = (
	minix	=> {	mkfs => [ qw(/root/mkfs.minix -v) ], },
	ext2	=> {},
	ext3	=> {},
	'ext3-wb' => {	type => 'ext3', mountopts => 'data=writeback', },
	'ext3-jd' => {	mkfs => [ qw(mkfs.ext3 -J size=200 )],
			type => 'ext3', mountopts => 'data=journal', },
	jfs	=> {	mkfs => [ qw(mkfs.jfs -q) ], },
	reiser	=> {	type => 'reiserfs', },
);

my %dbs = (
	mysql	=> { mntpoint => '/var/lib/mysql', osdb => 'osdb-my', },
	postgresql => { mntpoint => '/var/lib/pgsql', osdb => 'osdb-pg',
			init => \&pg_init, },
);

runit('umount', $PART);

foreach my $db (@DBS) {
	my $dbopts = $dbs{$db};
	my $mntpoint = $dbopts->{mntpoint} or die "$db has no mntpoint\n";
	my $osdb = $dbopts->{osdb} or die "$db has no \"osdb\"\n";

	foreach my $fs (@FSES) {
		my $opts = $filesystems{$fs};
		print "Benchmark for ", $db, " on ", $fs, "\n\n";

		my $fstype = $opts->{type} || $fs;
		my $mkfs = $opts->{mkfs} || [ qw(mkfs -t), $fstype ];
		print "making fs\n";
		runit(@$mkfs, $PART) or die "can't mkfs $fstype\n";
		print "\n\n";

		print "mounting fs\n";
		my $opt = $opts->{mountopts} || $DEFOPTS;
		$opt = [$opt] if $opt && ! ref $opt;
		push @$opt, $FORCEOPTS;
		$opt = join(",", @$opt);
		$opt = ['-o', $opt] if $opt;
		runit('mount', '-t', $fstype, @$opt, $PART, $mntpoint)
					or die "can't mount $fstype\n";
		print "\n\n";

		print "Starting ", $db, "\n";
		if ($dbopts->{init}) {
			&{$dbopts->{init}}($dbopts, $opts);
		} else {
			runit('/sbin/service', $db, 'start');
		}
		print "\n\n";

		print "Running test\n";
		runit($osdb, @BENCHOPTS) or warn "tests failed\n";
		print "\n\n";

		print "Stopping ", $db, "\n";
		runit('/sbin/service', $db, 'stop');
		sleep(2);
		print "\n\n";

		print "Umounting\n";
		runit('umount', $PART) or die "can't umount $fstype\n";
		print "\n\n";

		print "\n\n";
		print "\n\n";
	}
}


exit;



sub pg_init {
	my $dbopts = shift;
	my $opts = shift;
	my $mp = $dbopts->{mntpoint};

	my @dirs = ($mp.'/data', $mp.'/backups');
	runit('mkdir', '-m', '0700', @dirs);
	runit('chown', 'postgres.postgres', @dirs);
#	runit('cp', '/etc/postgresql.conf', $dirs[0]);
	runit('/sbin/service', 'postgresql', 'start');
	sleep(2);
	runit('sudo', '-u', 'postgres', 'createuser', '-a', '-d', 'root');
}

sub runit {
	print join(" ", @_), "\n" if $DEBUG || $DEBUGONLY;
	return !system(@_) unless $DEBUGONLY;
}

