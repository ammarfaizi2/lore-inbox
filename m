Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSGMNMZ>; Sat, 13 Jul 2002 09:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSGMNMY>; Sat, 13 Jul 2002 09:12:24 -0400
Received: from mx2.airmail.net ([209.196.77.99]:47880 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S312938AbSGMNLr>;
	Sat, 13 Jul 2002 09:11:47 -0400
Date: Sat, 13 Jul 2002 08:14:32 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [SCRIPT] designated initializer conversion, take 2
Message-ID: <20020713131432.GC14130@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

A couple of days ago I posted a script that converts structure
initializers from the form ...

struct foo = {
	field:	val
}

to 

struct foo = {
	.field = val
}

The latest version of the script is attached. This version
changes more structures, as well as adds a few missed fields
to the conversion. I'm running a kernel based on the code
that the script converted, so the output works here.

I've heard from Rusty Russell regarding the earlier version
of the script, and will possibly be sending him patches based
on the output. The script changes 679 files in my kernel, so
that is a lot of potential patches.

As for the script itself, I confess it's gotten a bit uglier
as I added more things that it knows to convert.

My thanks to everyone working on the kernel.

Art Haas

-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759

--hHWLQfXTYDoKhP50
Content-Type: application/x-perl
Content-Disposition: attachment; filename="decfix.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A=0A#=0A# quick scanner for possible obsolete format=0A# f=
or the designated initializers=0A#=0A=0Ause strict;=0A=0Adie "No starting d=
irectory given!\n" unless (@ARGV);=0A=0Amy $startdir =3D shift(@ARGV);=0A=
=0Adie "Can't find directory `$startdir'! $!\n" unless (-d $startdir);=0A=
=0Amy %operations =3D (=0A		  'block_device' =3D> {=0A				     'open' =3D> =
1,=0A				     'release' =3D> 1,=0A				     'ioctl' =3D> 1,=0A				     'chec=
k_media_change' =3D> 1,=0A				     'revalidate' =3D> 1,=0A				     'owner' =
=3D> 1=0A				    },=0A=0A		  'file' =3D> {=0A			     'owner' =3D> 1,=0A			 =
    'llseek' =3D> 1,=0A			     'read' =3D> 1,=0A			     'write' =3D> 1,=0A	=
		     'readdir' =3D> 1,=0A			     'poll' =3D> 1,=0A			     'ioctl' =3D> 1,=
=0A			     'mmap' =3D> 1,=0A			     'open' =3D> 1,=0A			     'flush' =3D> 1=
,=0A			     'release' =3D> 1,=0A			     'fsync' =3D> 1,=0A			     'fasync' =
=3D> 1,=0A			     'lock' =3D> 1,=0A			     'readv' =3D> 1,=0A			     'write=
v' =3D> 1,=0A			     'sendpage' =3D> 1,=0A			     'get_unmapped_area' =3D> =
1=0A			    },=0A		  'inode' =3D> {=0A			      'create' =3D> 1,=0A			      '=
lookup' =3D> 1,=0A			      'link' =3D> 1,=0A			      'unlink' =3D> 1,=0A			=
      'symlink' =3D> 1,=0A			      'mkdir' =3D> 1,=0A			      'rmdir' =3D> =
1,=0A			      'mknod' =3D> 1,=0A			      'rename' =3D> 1,=0A			      'readl=
ink'=3D> 1,=0A			      'follow_link' =3D> 1,=0A			      'truncate' =3D> 1,=
=0A			      'permission' =3D> 1,=0A			      'revalidate' =3D> 1,=0A			     =
 'setattr' =3D> 1,=0A			      'getattr' =3D> 1=0A			     },=0A		  'super' =
=3D> {=0A			      'read_inode' =3D> 1,=0A			      'read_inode2' =3D> 1,=0A	=
		      'dirty_inode' =3D> 1,=0A			      'write_inode' =3D> 1,=0A			      '=
put_inode' =3D> 1,=0A			      'delete_inode' =3D> 1,=0A			      'put_super'=
 =3D> 1,=0A			      'write_super' =3D> 1,=0A			      'write_super_lockfs' =
=3D> 1,=0A			      'unlockfs' =3D> 1,=0A			      'statfs' =3D> 1,=0A			    =
  'remount_fs' =3D> 1,=0A			      'clear_inode' =3D> 1,=0A			      'umount_=
begin' =3D> 1,=0A			      'fh_to_dentry' =3D> 1,=0A			      'dentry_to_fh' =
=3D> 1,=0A			      'show_options' =3D> 1=0A			     },=0A		  'dquot' =3D> {=
=0A			      'initialize' =3D> 1,=0A			      'drop' =3D> 1,=0A			      'allo=
c_space' =3D> 1,=0A			      'alloc_inode' =3D> 1,=0A			      'free_space' =
=3D> 1,=0A			      'free_inode' =3D> 1,=0A			      'transfer' =3D> 1=0A			 =
    },=0A		  'vm' =3D> {=0A			   'open' =3D> 1,=0A			   'close' =3D> 1,=0A	=
		   'nopage' =3D> 1=0A			   },=0A		  'dentry' =3D> {=0A			       'd_revali=
date' =3D> 1,=0A			       'd_hash' =3D> 1,=0A			       'd_compare' =3D> 1,=
=0A			       'd_delete' =3D> 1,=0A			       'd_release' =3D> 1,=0A			      =
 'd_iput' =3D> 1=0A			       },=0A		  'parport' =3D> {=0A				'write_data' =
=3D> 1,=0A				'read_data' =3D> 1,=0A				'write_control' =3D> 1,=0A				'read=
_control' =3D> 1,=0A				'frob_control' =3D> 1,=0A				'read_status' =3D> 1,=
=0A				'enable_irq' =3D> 1,=0A				'disable_irq' =3D> 1,=0A				'data_forward=
' =3D> 1,=0A				'data_reverse' =3D> 1,=0A				'init_state' =3D> 1,=0A				'sa=
ve_state' =3D> 1,=0A				'restore_state' =3D> 1,=0A				'inc_use_count' =3D> =
1,=0A				'dec_use_count' =3D> 1,=0A				'epp_write_data' =3D> 1,=0A				'epp_=
read_data' =3D> 1,=0A				'epp_write_addr' =3D> 1,=0A				'epp_read_addr' =3D=
> 1,=0A				'ecp_write_data' =3D> 1,=0A				'ecp_read_data' =3D> 1,=0A				'ec=
p_write_addr' =3D> 1,=0A				'compat_write_data' =3D> 1,=0A				'nibble_read_=
data' =3D> 1,=0A				'byte_read_data' =3D> 1=0A			       },=0A		  'address_s=
pace' =3D> {=0A				      'writepage' =3D> 1,=0A				      'readpage' =3D> 1,=
=0A				      'sync_page' =3D> 1,=0A				      'prepare_write' =3D> 1,=0A				=
      'commit_write' =3D> 1,=0A				      'bmap' =3D> 1,=0A				      'flushp=
age' =3D> 1,=0A				      'releasepage' =3D> 1,=0A				      'direct_IO' =3D>=
 1,=0A				      'removepage' =3D> 1=0A				      },=0A		  'seq' =3D> {=0A			=
    'start' =3D> 1,=0A			    'stop' =3D> 1,=0A			    'next' =3D> 1,=0A			  =
  'show' =3D> 1=0A			   },=0A		  'usb' =3D> {=0A			    'allocate' =3D> 1,=
=0A			    'deallocate' =3D> 1,=0A			    'get_frame_number' =3D> 1,=0A			   =
 'submit_urb' =3D> 1,=0A			    'unlink_urb' =3D> 1=0A			   },=0A		  'fb_ops=
' =3D> {=0A			       'owner' =3D> 1,=0A			       'fb_open' =3D> 1,=0A			   =
    'fb_release' =3D> 1,=0A			       'fb_get_fix' =3D> 1,=0A			       'fb_g=
et_var' =3D> 1,=0A			       'fb_set_var' =3D> 1,=0A			       'fb_get_cmap' =
=3D> 1,=0A			       'fb_set_cmap' =3D> 1,=0A			       'fb_pan_display' =3D>=
 1,=0A			       'fb_ioctl' =3D> 1,=0A			       'fb_mmap' =3D> 1,=0A			     =
  'fb_rastering' =3D> 1=0A			       },=0A		  'fbgen_hwswitch' =3D> {=0A				=
       'detect' =3D> 1,=0A				       'encode_fix' =3D> 1,=0A				       'dec=
ode_var' =3D> 1,=0A				       'encode_var' =3D> 1,=0A				       'get_par' =
=3D> 1,=0A				       'set_par' =3D> 1,=0A				       'getcolreg' =3D> 1,=0A	=
			       'setcolreg' =3D> 1,=0A				       'pan_display' =3D> 1,=0A				    =
   'blank' =3D> 1,=0A				       'set_disp' =3D> 1=0A				       },=0A		  'co=
nsw' =3D> {=0A			      'con_startup' =3D> 1,=0A			      'con_init' =3D> 1,=
=0A			      'con_deinit' =3D> 1,=0A			      'con_clear' =3D> 1,=0A			      =
'con_putc' =3D> 1,=0A			      'con_putcs' =3D> 1,=0A			      'con_cursor' =
=3D> 1,=0A			      'con_scroll' =3D> 1,=0A			      'con_bmove' =3D> 1,=0A		=
	      'con_switch' =3D> 1,=0A			      'con_blank' =3D> 1,=0A			      'con_=
fontop' =3D> 1,=0A			      'con_set_palette' =3D> 1,=0A			      'con_scroll=
delta' =3D> 1,=0A			      'con_set_origin' =3D> 1,=0A			      'con_save_scr=
een' =3D> 1,=0A			      'con_build_attr' =3D> 1,=0A			      'con_invert_reg=
ion' =3D> 1,=0A			      'con_screen_pos' =3D> 1,=0A			      'con_getxy' =3D=
> 1=0A			     },=0A		  'gameport_dev' =3D> {=0A				 'connect' =3D> 1,=0A			=
	 'disconnect' =3D> 1=0A				},=0A		  'ide_driver_t' =3D> {=0A				     'name=
' =3D> 1,=0A				     'version' =3D> 1,=0A				     'media' =3D> 1,=0A				   =
  'busy' =3D> 1,=0A				     'supports_dma' =3D> 1,=0A				     'supports_dsc=
_overlap' =3D> 1,=0A				     'cleanup' =3D> 1,=0A				     'standby' =3D> 1,=
=0A				     'suspend' =3D> 1,=0A				     'resume' =3D> 1,=0A				     'flush=
cache' =3D> 1,=0A				     'do_request' =3D> 1,=0A				     'end_request' =3D=
> 1,=0A				     'sense' =3D> 1,=0A				     'error' =3D> 1,=0A				     'open=
' =3D> 1,=0A				     'ioctl' =3D> 1,=0A				     'release' =3D> 1,=0A				   =
  'media_change' =3D> 1,=0A				     'revalidate' =3D> 1,=0A				     'pre_re=
set' =3D> 1,=0A				     'capacity' =3D> 1,=0A				     'special' =3D> 1,=0A	=
			     'proc' =3D> 1,=0A				     'init' =3D> 1,=0A				     'reinit' =3D> 1=
,=0A				     'ata_prebuilder' =3D> 1,=0A				     'atapi_prebuilder' =3D> 1=
=0A				    },=0A		  'cdrom_device_ops' =3D> {=0A					 'open' =3D> 1,=0A				=
	 'release' =3D> 1,=0A					 'drive_status' =3D> 1,=0A					 'media_changed' =
=3D> 1,=0A					 'tray_move' =3D> 1,=0A					 'lock_door' =3D> 1,=0A					 'se=
lect_speed' =3D> 1,=0A					 'select_disc' =3D> 1,=0A					 'get_last_session=
' =3D> 1,=0A					 'get_mcn' =3D> 1,=0A					 'reset' =3D> 1,=0A					 'audio_=
ioctl' =3D> 1,=0A					 'dev_ioctl' =3D> 1,=0A					 'capability' =3D> 1,=0A	=
				 'n_minors' =3D> 1,=0A					 'generate_packet' =3D> 1,=0A					},=0A		  '=
cdrom_device_info' =3D> {=0A					  'opts' =3D> 1,=0A					  'next' =3D> 1,=
=0A					  'handle' =3D> 1,=0A					  'de' =3D> 1,=0A					  'number' =3D> 1,=
=0A					  'dev' =3D> 1,=0A					  'mask' =3D> 1,=0A					  'speed' =3D> 1,=0A=
					  'capacity' =3D> 1,=0A					  'options' =3D> 1,=0A					  'mc_flags' =
=3D> 1,=0A					  'use_count' =3D> 1,=0A					  'name' =3D> 1,=0A					  'sany=
o_slot' =3D> 1,=0A					  'reserved' =3D> 1,=0A					  'write' =3D> 1=0A					=
 },=0A		  'hw_interrupt_type' =3D> {=0A					  'typename' =3D> 1,=0A					  '=
startup' =3D> 1,=0A					  'shutdown' =3D> 1,=0A					  'enable' =3D> 1,=0A		=
			  'disable' =3D> 1,=0A					  'ack' =3D> 1,=0A					  'send' =3D> 1,=0A			=
		  'set_affinity' =3D> 1=0A					 },=0A		  'miscdevice' =3D> {=0A				   'mi=
nor' =3D> 1,=0A				   'name' =3D> 1,=0A				   'fops' =3D> 1,=0A				   'prev=
' =3D> 1,=0A				   'devfs_handle' =3D> 1,=0A				  },=0A		  'usb_driver' =3D=
> {=0A				   'name' =3D> 1,=0A				   'probe' =3D> 1,=0A				   'disconnect' =
=3D> 1,=0A				   'driver_list' =3D> 1,=0A				   'fops' =3D> 1,=0A				   'mi=
nor' =3D> 1,=0A				   'serialize' =3D> 1,=0A				   'ioctl' =3D> 1,=0A				  =
 'id_table' =3D> 1,=0A				   'suspend' =3D> 1,=0A				   'resume' =3D> 1,=0A=
				  },=0A		  'usb_serial_device_type' =3D> {=0A					       'name' =3D> 1,=
=0A					       'id_table' =3D> 1,=0A					       'needs_interrupt_in' =3D> 1=
,=0A					       'needs_bulk_in' =3D> 1,=0A					       'needs_bulk_out' =3D>=
 1,=0A					       'num_interrupt_in' =3D> 1,=0A					       'num_bulk_in' =
=3D> 1,=0A					       'num_bulk_out' =3D> 1,=0A					       'num_ports' =3D>=
 1,=0A					       'driver_list' =3D> 1,=0A					       'startup' =3D> 1,=0A	=
				       'shutdown' =3D> 1,=0A					       'open' =3D> 1,=0A					       'c=
lose' =3D> 1,=0A					       'write' =3D> 1,=0A					       'write_room' =3D>=
 1,=0A					       'ioctl' =3D> 1,=0A					       'set_termios' =3D> 1,=0A			=
		       'break_ctl' =3D> 1,=0A					       'chars_in_buffer' =3D> 1,=0A				=
	       'throttle' =3D> 1,=0A					       'unthrottle' =3D> 1,=0A					      =
 'read_int_callback' =3D> 1,=0A					       'read_bulk_callback' =3D> 1,=0A	=
				       'write_bulk_callback' =3D> 1,=0A					      },=0A		  'pci_driver'=
 =3D> {=0A				   'node' =3D> 1,=0A				   'name' =3D> 1,=0A				   'id_table'=
 =3D> 1,=0A				   'probe' =3D> 1,=0A				   'remove' =3D> 1,=0A				   'save_=
state' =3D> 1,=0A				   'suspend' =3D> 1,=0A				   'resume' =3D> 1,=0A				 =
  'enable_wake' =3D> 1,=0A				  },=0A		  'proto' =3D> {=0A			      'close' =
=3D> 1,=0A			      'connect' =3D> 1,=0A			      'disconnect' =3D> 1,=0A			 =
     'accept' =3D> 1,=0A			      'ioctl' =3D> 1,=0A			      'init' =3D> 1,=
=0A			      'destroy' =3D> 1,=0A			      'shutdown' =3D> 1,=0A			      'set=
sockopt' =3D> 1,=0A			      'getsockopt' =3D> 1,=0A			      'sendmsg' =3D> =
1,=0A			      'recvmsg' =3D> 1,=0A			      'bind' =3D> 1,=0A			      'backl=
og_rcv' =3D> 1,=0A			      'hash' =3D> 1,=0A			      'unhash' =3D> 1,=0A			=
      'get_port' =3D> 1,=0A			      'name' =3D> 1,=0A			     },=0A		  'prot=
o_ops' =3D> {=0A				  'family' =3D> 1,=0A				  'release' =3D> 1,=0A				  'b=
ind' =3D> 1,=0A				  'connect' =3D> 1,=0A				  'socketpair' =3D> 1,=0A				 =
 'accept' =3D> 1,=0A				  'getname' =3D> 1,=0A				  'poll' =3D> 1,=0A				  =
'ioctl' =3D> 1,=0A				  'listen' =3D> 1,=0A				  'shutdown' =3D> 1,=0A				 =
 'setsockopt' =3D> 1,=0A				  'getsockopt' =3D> 1,=0A				  'sendmsg' =3D> 1=
,=0A				  'recvmsg' =3D> 1,=0A				  'mmap' =3D> 1,=0A				  'sendpage' =3D> =
1,=0A				 },=0A		  'net_proto_family' =3D> {=0A					 'family' =3D> 1,=0A			=
		 'create' =3D> 1,=0A					 'autentication' =3D> 1,=0A					 'encryption' =
=3D> 1,=0A					 'encrypt_net' =3D> 1,=0A					},=0A=0A		  'inet_protosw' =3D=
> {=0A				     'list' =3D> 1,=0A				     'type' =3D> 1,=0A				     'protoco=
l' =3D> 1,=0A				     'prot' =3D> 1,=0A				     'ops' =3D> 1,=0A				     'c=
apability' =3D> 1,=0A				     'no_check' =3D> 1,=0A				     'flags' =3D> 1,=
=0A				    },=0A		  'hci_proto' =3D> {=0A				  'name' =3D> 1,=0A				  'id' =
=3D> 1,=0A				  'flags' =3D> 1,=0A				  'priv' =3D> 1,=0A				  'connect_ind=
' =3D> 1,=0A				  'connect_cfm' =3D> 1,=0A				  'disconn_ind' =3D> 1,=0A			=
	  'recv_acldata' =3D> 1,=0A				  'recv_scodata' =3D> 1,=0A				  'auth_cfm'=
 =3D> 1,=0A				  'encrypt_cfm' =3D> 1,=0A				 },=0A		  'hci_uart_proto' =3D=
> {=0A				       'id' =3D> 1,=0A				       'open' =3D> 1,=0A				       'rec=
v' =3D> 1,=0A				       'send' =3D> 1,=0A				       'close' =3D> 1,=0A				 =
      'flush' =3D> 1,=0A				       'preq' =3D> 1,=0A				      },=0A		 );=0A=
		=0Amy @dirs =3D ();=0Apush(@dirs,$startdir);=0A=0Awhile(defined(my $dir =
=3D pop(@dirs))) {=0A  opendir(DIR,$dir) || die "Can't open directory `$dir=
'! $!\n";=0A  my @files =3D grep(!/^\.\.?$/, readdir(DIR));=0A  closedir(DI=
R);=0A  foreach (@files) {=0A    my $fname =3D join("/", $dir, $_);=0A    i=
f (-d $fname) {=0A      push(@dirs, $fname);=0A      next;=0A    }=0A    ne=
xt unless ($fname =3D~ /\.c$/);=0A    open(CFILE,"<$fname") || die "Can't o=
pen `$fname'! $!\n";=0A    my @newlines =3D ();=0A    my $opflag =3D 0;=0A =
   my $writeflag =3D 0;=0A    my $key =3D '';=0A    while(<CFILE>) {=0A    =
  if (/(block_device|file|inode|super|dquot|vm|dentry|parport|address_space=
|seq|usb)_operations\s+\S+\s+\=3D/) {=0A	$key =3D $1;=0A	$opflag =3D 1;=0A =
     } elsif (/\s(miscdevice|cdrom_device_ops|ide_driver_t|usb_driver|usb_s=
erial_device_type|pci_driver|proto|proto_ops|inet_protosw)\s+\S+\s+\=3D/) {=
=0A	$key =3D $1;=0A	$opflag =3D 1;=0A      } else {=0A	if (/\s(consw|fb_ops=
|fbgen_hwswitch|gameport_dev|net_proto_family|hci_proto|hci_uart_proto)\s+\=
S+\s+\=3D/) {=0A	  $key =3D $1;=0A	  $opflag =3D 1;=0A	}=0A      }=0A      =
unless ($opflag) {=0A	push(@newlines,$_);=0A	next;=0A      }=0A      if (m!=
([^\w\s]+)\s*([\w_]+):\s*(.+)$!) {=0A	if (exists($operations{$key}->{$2})) =
{=0A	  $writeflag++;=0A	  push(@newlines,"\t$1 .$2 =3D $3\n");=0A	} else {=
=0A	  push(@newlines,$_);=0A	}=0A      } elsif (m!([\w_]+):\s*(.+)$!) {=0A	=
if (exists($operations{$key}->{$1})) {=0A	  $writeflag++;=0A	  push(@newlin=
es,"\t.$1 =3D $2\n");=0A	} else {=0A	  push(@newlines,$_);=0A	}=0A      } e=
lse{=0A	push(@newlines,$_);=0A      }=0A      if (m!\};!) {=0A	$opflag =3D =
0;=0A      }=0A    }=0A    close(CFILE);=0A    if ($writeflag) {=0A      my=
 $newname =3D join(".", $fname, 'new');=0A      open(NEWFILE,">$newname") |=
| die "Can't create `$newname'! $!\n";=0A      print NEWFILE @newlines;=0A =
     close(NEWFILE) || die "Error writing `$newname'! $!\n";=0A      my $ol=
dname =3D join(".", $fname, 'old');=0A      rename($fname, $oldname) || die=
 "Can't rename '$fname'! $!\n";=0A      rename($newname, $fname) || die "Ca=
n't rename '$newname'! $!\n";=0A    }=0A  }=0A}=0A
--hHWLQfXTYDoKhP50--
