Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317724AbSGKCuL>; Wed, 10 Jul 2002 22:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317725AbSGKCuK>; Wed, 10 Jul 2002 22:50:10 -0400
Received: from mx2.airmail.net ([209.196.77.99]:41233 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S317724AbSGKCuH>;
	Wed, 10 Jul 2002 22:50:07 -0400
Date: Wed, 10 Jul 2002 21:52:48 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: [SCRIPT] designated initializer conversion
Message-ID: <20020711025248.GA486@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Near the end of May, there was a thread on the kernel mailing
list about converting structure initializers from the present
form like ...

struct foo_operations foo_ops = {
	op1:	func1,
	op2:	func2,
}

to the C99 format like ...

struct foo_operations foo_ops = {
	.op1 = func1,
	.op2 = func2,
}

The format with the colons is described in the GCC info pages
in the "C Extensions" -> "Designated Inits" section. The info
page lists this format as being obsolete since GCC 2.5, so there
was talk about cleaning up the kernel to move off this extension
and convert the ISO standard format. I haven't seen any patches
make their way out doing this change, though as I'm running
the 2.4 series kernels, maybe some have filtered into 2.5.

One day while getting frustrated with something I was working
on, I decided to change gears and tackle this conversion. I
cooked up a nifty little Perl script that does this, and
can say I'm running a kernel now (2.4.19-rc1-ac1) that the
script has ISOized. The script is passed a directory
as an argument, and will change all files in that directory
and any subdirectory that seem to warrant the change. I went
nuts and did my whole kernel, and out of the stuff I built,
especially many filesystem modules , I only encountered a problem
with the fs/affs/file.c file. The '.writepage' and '.sync_page'
lines around 792 were commented out, and my conversion script
dropped the comments. Other than that, my conversion went
without a hitch. I built my kernel with gcc-2.95.4 (Debian),
so I know it works with that GCC release. GCC 3.X will also
work, as I've tried 3.1.1 earlier when fiddling around with
the script.

To use the script, simply pass a directory in which you want to
start the conversion. For example, if you want to convert
the code in the fs/ext2 directory ...

$ perl conv_script.pl /path/to/kernel/code/fs/ext2

To do all the file systems ...

$ perl conv_script.pl /path/to/kernel/code/fs

... and for the bold, to do the whole enchilada ...

$ perl conv_script.pl /path/to/kernel/code

Any file that the script converts is renamed with a ".old"
extension, so you'll be able to diff the changes. I also have
a simple shell script that can rename the changed file with
a ".new" extension, and swap the ".old" back. The shell
script is also included in this mail.

My hope is this script is useful to anyone wanting
to test out this code conversion, and will ease the
conversion to the ".foo" format if that is the path
the kernel developers wish to take.

My thanks to everyone working on the kernel.

Enough blabbering, here's the script ...

====================================================
#!/usr/bin/perl

#
# quick scanner for possible obsolete format
# for the designated initializers
#

use strict;

die "No starting directory given!\n" unless (@ARGV);

my $startdir = shift(@ARGV);

die "Can't find directory `$startdir'! $!\n" unless (-d $startdir);

my %operations = (
		  'block_device' => {
				     'open' => 1,
				     'release' => 1,
				     'ioctl' => 1,
				     'check_media_change' => 1,
				     'revalidate' => 1
				    },

		  'file' => {
			     'llseek' => 1,
			     'read' => 1,
			     'write' => 1,
			     'readdir' => 1,
			     'poll' => 1,
			     'ioctl' => 1,
			     'mmap' => 1,
			     'open' => 1,
			     'flush' => 1,
			     'release' => 1,
			     'fsync' => 1,
			     'fasync' => 1,
			     'lock' => 1,
			     'readv' => 1,
			     'writev' => 1,
			     'sendpage' => 1,
			     'get_unmapped_area' => 1
			    },
		  'inode' => {
			      'create' => 1,
			      'lookup' => 1,
			      'link' => 1,
			      'unlink' => 1,
			      'symlink' => 1,
			      'mkdir' => 1,
			      'rmdir' => 1,
			      'mknod' => 1,
			      'rename' => 1,
			      'readlink'=> 1,
			      'follow_link' => 1,
			      'truncate' => 1,
			      'permission' => 1,
			      'revalidate' => 1,
			      'setattr' => 1,
			      'getattr' => 1
			     },
		  'super' => {
			      'read_inode' => 1,
			      'read_inode2' => 1,
			      'dirty_inode' => 1,
			      'write_inode' => 1,
			      'put_inode' => 1,
			      'delete_inode' => 1,
			      'put_super' => 1,
			      'write_super' => 1,
			      'write_super_lockfs' => 1,
			      'unlockfs' => 1,
			      'statfs' => 1,
			      'remount_fs' => 1,
			      'clear_inode' => 1,
			      'umount_begin' => 1,
			      'fh_to_dentry' => 1,
			      'dentry_to_fh' => 1,
			      'show_options' => 1
			     },
		  'dquot' => {
			      'initialize' => 1,
			      'drop' => 1,
			      'alloc_space' => 1,
			      'alloc_inode' => 1,
			      'free_space' => 1,
			      'free_inode' => 1,
			      'transfer' => 1
			     },
		  'vm' => {
			   'open' => 1,
			   'close' => 1,
			   'nopage' => 1
			   },
		  'dentry' => {
			       'd_revalidate' => 1,
			       'd_hash' => 1,
			       'd_compare' => 1,
			       'd_delete' => 1,
			       'd_release' => 1,
			       'd_iput' => 1
			       },
		  'parport' => {
				'write_data' => 1,
				'read_data' => 1,
				'write_control' => 1,
				'read_control' => 1,
				'frob_control' => 1,
				'read_status' => 1,
				'enable_irq' => 1,
				'disable_irq' => 1,
				'data_forward' => 1,
				'data_reverse' => 1,
				'init_state' => 1,
				'save_state' => 1,
				'restore_state' => 1,
				'inc_use_count' => 1,
				'dec_use_count' => 1,
				'epp_write_data' => 1,
				'epp_read_data' => 1,
				'epp_write_addr' => 1,
				'epp_read_addr' => 1,
				'ecp_write_data' => 1,
				'ecp_read_data' => 1,
				'ecp_write_addr' => 1,
				'compat_write_data' => 1,
				'nibble_read_data' => 1,
				'byte_read_data' => 1
			       },
		  'address_space' => {
				      'writepage' => 1,
				      'readpage' => 1,
				      'sync_page' => 1,
				      'prepare_write' => 1,
				      'commit_write' => 1,
				      'bmap' => 1,
				      'flushpage' => 1,
				      'releasepage' => 1,
				      'direct_IO' => 1,
				      'removepage' => 1
				      },
		  'seq' => {
			    'start' => 1,
			    'stop' => 1,
			    'next' => 1,
			    'show' => 1
			   },
		  'usb' => {
			    'allocate' => 1,
			    'deallocate' => 1,
			    'get_frame_number' => 1,
			    'submit_urb' => 1,
			    'unlink_urb' => 1
			   }
		 );
		
my @dirs = ();
push(@dirs,$startdir);

while(defined(my $dir = pop(@dirs))) {
  opendir(DIR,$dir) || die "Can't open directory `$dir'! $!\n";
  my @files = grep(!/^\.\.?$/, readdir(DIR));
  closedir(DIR);
  foreach (@files) {
    my $fname = join("/", $dir, $_);
    if (-d $fname) {
      push(@dirs, $fname);
      next;
    }
    next unless ($fname =~ /\.c$/);
    open(CFILE,"<$fname") || die "Can't open `$fname'! $!\n";
    my @newlines = ();
    my $opflag = 0;
    my $writeflag = 0;
    my $key = '';
    while(<CFILE>) {
      if (/(block_device|file|inode|super|dquot|vm|dentry|parport|address_space|seq|usb)_operations\s+\S+\s+\=/) {
	$key = $1;
	$opflag = 1;
      }
      unless ($opflag) {
	push(@newlines,$_);
	next;
      }
      if (m!([\w_]+):\s+(.+)$!) {
	if (exists($operations{$key}->{$1})) {
	  $writeflag++;
	  push(@newlines,"\t.$1 = $2\n");
	} else {
	  push(@newlines,$_);
	}
      } else{
	push(@newlines,$_);
      }
      if (m!\};!) {
	$opflag = 0;
      }
    }
    close(CFILE);
    if ($writeflag) {
      my $newname = join(".", $fname, 'new');
      open(NEWFILE,">$newname") || die "Can't create `$newname'! $!\n";
      print NEWFILE @newlines;
      close(NEWFILE) || die "Error writing `$newname'! $!\n";
      my $oldname = join(".", $fname, 'old');
      rename($fname, $oldname) || die "Can't rename '$fname'! $!\n";
      rename($newname, $fname) || die "Can't rename '$newname'! $!\n";
    }
  }
}
===================================================

... and now here's the shell script that renames the files ...

==========================================
#!/bin/sh

#
# small script to rename files
#

if [ -z $1 ]; then
    echo "Pass a directory!"
    exit 1
fi

dir=$1

if [ ! -d ${dir} ]; then
    echo "Can't find directory ${dir}!"
    exit 1
fi

for file in $(find ${dir} -name "*\.c\.old")
do
    testfile=${file%%.old}
    if [ -f ${testfile} ]; then
	echo "Replacing ${testfile}"
	mv ${testfile} ${testfile}.new
	mv ${file} ${testfile}
    fi
done
============================================

Comments welcomed.

Art Haas
-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
