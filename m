Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263814AbRFCXzY>; Sun, 3 Jun 2001 19:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263811AbRFCXYQ>; Sun, 3 Jun 2001 19:24:16 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:19260 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S263589AbRFCW43>; Sun, 3 Jun 2001 18:56:29 -0400
Date: Sun, 3 Jun 2001 18:56:27 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: XMM: monitor Linux MM inactive/active lists graphically
In-Reply-To: <87d78lolxs.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.10.10106031828390.7303-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> XMM is heavily modified XMEM utility that shows graphically size of
> different Linux page lists: active, inactive_dirty, inactive_clean,
> code, free and swap usage. It is better suited for the monitoring of
> Linux 2.4 MM implementation than original (XMEM) utility.
> 
> Find it here:  <URL:http://linux.inet.hr/>

interesting.  I prefer to collect data separately from viewing it,
and use the following simple perl script to do so; obviously, 
it generates a bunch of separate files, one for each metric,
suitable for traditional filtering, gnuplot, etc.

#!/bin/perl
use IO::Handle;

require 'sys/syscall.ph';
sub gettimeofday {
    $timeval = pack("LL", ());
    syscall( &SYS_gettimeofday, $timeval, 0) != -1
	or die "gettimeofday: $!";
    ($sec,$usec) = unpack("LL", $timeval);
    return $sec + 1e-6 * $usec;
}

open(S,"</proc/stat") || die("failed to open /proc/stat");
open(M,"</proc/meminfo") || die("failed to open /proc/meminfo");
open(B,"</proc/slabinfo") || die("failed to open /proc/slabinfo");

open(PI,">pi.st"); 	PI->autoflush(1);
open(PO,">po.st");	PO->autoflush(1);
open(SI,">si.st");	SI->autoflush(1);
open(SO,">so.st");	SO->autoflush(1);
open(CX,">ctx.st");	CX->autoflush(1);
open(MF,">free.st");	MF->autoflush(1);
open(BF,">buf.st");	BF->autoflush(1);
open(AC,">act.st");	AC->autoflush(1);
open(ID,">id.st");	ID->autoflush(1);
open(IC,">ic.st");	IC->autoflush(1);
open(IT,">it.st");	IT->autoflush(1);
open(SW,">swap.st");	SW->autoflush(1);
open(BH,">bh.st");	BH->autoflush(1);
open(IN,">inode.st");	IN->autoflush(1);
open(DE,">dentry.st");	DE->autoflush(1);

$c = 0;
$first = gettimeofday();
while (1) {
      sleep(1);
      $now = gettimeofday() - $first;

      seek(S,0,SEEK_SET);
      while (<S>) {
	  if (/^page\s+(\d+)\s+(\d+)$/) {
	      if ($c) { print PI "$now ",4*($1 - $pi),"\n"; }
	      if ($c) { print PO "$now ",4*($2 - $po),"\n"; }
	      $pi = $1;
	      $po = $2;
	      next;
	  }
	  if (/^swap\s+(\d+)\s+(\d+)$/) {
	      if ($c) { print SI "$now ",4*($1 - $si),"\n"; }
	      if ($c) { print SO "$now ",4*($2 - $so),"\n"; }
	      $si = $1;
	      $so = $2;
	      next;
	  }
	  if (/^ctxt\s+(\d+)$/) {
	      if ($c) { print CX "$now ",$1 - $cx,"\n"; }
	      $cx = $1;
	      next;
	  }
      }
      seek(M,0,SEEK_SET);
      while (<M>) {
	  if (/^MemFree:\s+(\d+) kB$/) {	print MF "$now ",$1,"\n"; next; }
	  if (/^Buffers:\s+(\d+) kB$/) {	print BF "$now ",$1,"\n"; next; }
	  if (/^Active:\s+(\d+) kB$/) {		print AC "$now ",$1,"\n"; next; }
	  if (/^Inact_dirty:\s+(\d+) kB$/) {	print ID "$now ",$1,"\n"; next; }
	  if (/^Inact_clean:\s+(\d+) kB$/) {	print IC "$now ",$1,"\n"; next; }
	  if (/^Inact_target:\s+(\d+) kB$/) {	print IT "$now ",$1,"\n"; next; }
	  if (/^Inact_target:\s+(\d+) kB$/) {	print IT "$now ",$1,"\n"; next; }
	  if (/^Swap:\s+\d+\s+(\d+)/) 	{	print SW "$now ",$1,"\n"; next; }
      }
      seek(B,0,SEEK_SET);
      while (<B>) {
	  if (/^buffer_head\s+(\d+)\s+(\d+)\s+(\d+)/) {	print BH "$now ",$1*$3/1024,"\n"; next; }
	  if (/^inode_cache\s+(\d+)\s+(\d+)\s+(\d+)/) {	print IN "$now ",$1*$3/1024,"\n"; next; }
	  if (/^dentry_cache\s+(\d+)\s+(\d+)\s+(\d+)/) {print DE "$now ",$1*$3/1024,"\n"; next; }
      }
      $c++;
}

