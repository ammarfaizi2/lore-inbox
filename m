Return-Path: <linux-kernel-owner+w=401wt.eu-S1030338AbXAEFjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbXAEFjQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 00:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbXAEFjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 00:39:16 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:55496 "EHLO gaz.sfgoth.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030338AbXAEFjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 00:39:15 -0500
Date: Thu, 4 Jan 2007 21:59:27 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Duplicated functions (was: fix memory corruption from misinterpreted bad_inode_ops return values)
Message-ID: <20070105055927.GL35756@gaz.sfgoth.com>
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com> <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org> <20070104232106.GK35756@gaz.sfgoth.com> <20070104235226.GA17561@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20070104235226.GA17561@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 04 Jan 2007 21:59:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Thu, Jan 04, 2007 at 03:21:06PM -0800, Mitchell Blank Jr wrote:
> > The real (but harder) fix for the wasted space issue
> > would be to get the toolchain to automatically combine functions that
> > end up compiling into identical assembly.
>=20
> Can't do.
[...]
> Comparing pointers to
> functions for equality is a well-defined operation and it's not
> to be messed with.

I agree -- it definitely could never be an "always on" optimization.  What I
was postulating would be a special post-processing step that could be run by
people interested in squeezing the kernel as small as possible.  I'd bet
that there's not many functions in the kernel that rely on having a unique
address.  If some exist they could be put in their own ELF section via
a "__unique_function_address_needed" macro or something.

> You _can_ compile g into jump to f, but that's it.

Actually if you don't mind sacrificing alignment (which we do anyway with -=
Os,
I think) you could give a function two unique addresses just by prepending =
it
with a single-byte noop instruction.

But anyway... how about some actual data?

Just out of curiosity I threw together a quick script (attached) that
parses the output of "objdump --disassemble vmlinux" and tries to find
functions that share the same opcodes.  The short summary of the results:
a bit of .text savings but not an amazing amount -- on my tiny nfsroot
test kernel it found 4034 bytes worth of possible savings (out of a total
of 1460830 bytes of opcodes in .text)  About what I expected, actually.

One line in its output really stands out, however:

| 218 bytes: __copy_from_user_ll_nozero, __copy_from_user_ll, __copy_to_use=
r_ll

Those three big functions are exactly the same, which actually makes sense
if you think about how they're implemented.  That's a bunch of *very* hot
Icache lines we're wasting there!

Anyway, hopefully some folks will find the script interesting.  In particul=
ar
maybe the janitors can play with it.  I'd wager some of the things it
turns up are good candidates for code re-use.

-Mitch

Script's output:

Duplicated functions:
  98 bytes: nlmsvc_proc_granted, nlm4svc_proc_granted
  10 bytes: return_EIO, hung_up_tty_write
  10 bytes: free_pid_ns, mempool_kfree, free_bd_holder, nfs4_free_open_stat=
e, ipc_immediate_free, dir_release, pci_release_bus_bridge_dev, put_tty_dri=
ver, device_create_release, class_create_release, class_device_create_relea=
se, isa_dev_release, neigh_parms_destroy, unx_destroy_cred, pmap_map_releas=
e, rpc_free_iostats, free
  15 bytes: xor_64, xor_64
  7 bytes: native_set_pte, native_set_pmd, debugfs_u32_set
  24 bytes: part_uevent_store, store_uevent
  54 bytes: atm_init_aal34, atm_init_aal5
  22 bytes: nfs4_encode_void, nlmsvc_encode_void, nlm4svc_encode_void
  42 bytes: seq_release_private, content_release
  10 bytes: profile_event_register, profile_event_unregister, nocrypt, nocr=
ypt_iv
  7 bytes: nfs_proc_commit_setup, udp_lib_hash, udp_lib_hash
  179 bytes: nlmsvc_proc_sm_notify, nlm4svc_proc_sm_notify
  29 bytes: nfs4_decode_void, nlmsvc_decode_void, nlm4svc_decode_void
  62 bytes: nfs3_commit_done, nfs3_write_done
  7 bytes: print_trace_stack, i8237A_suspend, store, module_frob_arch_secti=
ons, get_gate_vma, in_gate_area, in_gate_area_no_task, no_blink, noop_ret, =
no_action, next_online_pgdat, __pud_alloc, __pmd_alloc, generic_pipe_buf_pi=
n, simple_sync_file, nfs4_callback_null, fuse_prepare_write, default_read_f=
ile, dummycon_dummy, vgacon_dummy, read_null, hung_up_tty_read, con_chars_i=
n_buffer, class_device_create_uevent, anon_transport_dummy_function, ramdis=
k_writepages, sock_no_poll, noop_dequeue, ipv4_dst_check, rpcproc_encode_nu=
ll, rpcproc_decode_null, pvc_shutdown, svc_shutdown
  20 bytes: fn_show_ptregs, sysrq_handle_showregs
  29 bytes: part_next, diskstats_next
  10 bytes: atomic_notifier_call_chain, raw_notifier_call_chain
  107 bytes: nlm_decode_cookie, nlm4_decode_cookie
  5 bytes: do_spurious_interrupt_bug, c_stop, machine_shutdown, machine_hal=
t, syscall_vma_close, native_nop, sighand_ctor, r_stop, s_stop, audit_log_t=
ask_context, noop, default_unplug_io_fn, frag_stop, single_stop, t_stop, de=
vinfo_stop, int_seq_stop, parse_solaris_x86, parse_freebsd, parse_netbsd, p=
arse_openbsd, parse_unixware, parse_minix, nfs_server_list_stop, nfs_volume=
_list_stop, nfs3_forget_cached_acls, fuse_read_inode, ipc_lock_by_ptr, ipc_=
unlock, crypto_exit_cipher_ops, crypto_exit_digest_ops, ioport_unmap, pci_r=
emove_legacy_files, k_ignore, con_throttle, nv_vlan_rx_kill_vid, input_devi=
ces_seq_stop, input_handlers_seq_stop, proto_seq_stop, dev_seq_stop, softne=
t_seq_stop, dev_mc_seq_stop, neigh_stat_seq_stop, netlink_seq_stop, rt_cpu_=
seq_stop, tcp_twsk_destructor, raw_seq_stop, udp_seq_stop, icmp_address, ic=
mp_discard, fib_seq_stop, unix_seq_stop, packet_seq_stop, rpc_default_callb=
ack, nul_destroy, nul_destroy_cred, c_stop, vcc_seq_stop, smp_setup_process=
or_id, remapped_pgdat_init, pre_setup_arch_hook, trap_init_hook, sched_init=
_smp, push_node_boundaries, page_alloc_init
  16 bytes: svc_proc_unregister, rpc_proc_unregister
  70 bytes: nfs_execute_read, nfs_execute_write
  15 bytes: diskstats_stop, part_stop
  10 bytes: machine_restart, emergency_restart
  26 bytes: sysfs_put_link, fuse_put_link
  81 bytes: nlmsvc_decode_notify, nlm4svc_decode_notify
  68 bytes: svcauth_unix_release, svcauth_null_release
  15 bytes: nr_free_buffer_pages, nr_free_pagecache_pages
  20 bytes: ip_map_alloc, rsi_alloc, rsc_alloc
  182 bytes: nlmsvc_retrieve_args, nlm4svc_retrieve_args
  10 bytes: positive_have_wrcomb, compare_single, simple_delete_dentry, eve=
ntpollfs_delete_dentry, proc_delete_dentry, always_on, nul_match, hrtimer_c=
pu_notify
  44 bytes: notesize, notesize
  10 bytes: fn_show_mem, sysrq_handle_showmem
  10 bytes: unx_lookup_cred, gss_lookup_cred
  48 bytes: quirk_pcie_aspm_read, pci_read
  20 bytes: open_kcore, open_port
  29 bytes: part_attr_show, class_device_attr_show
  69 bytes: diskstats_start, part_start
  13 bytes: fn_show_state, sysrq_handle_showstate
  16 bytes: nfs_proc_lock, nfs3_proc_lock
  7 bytes: exact_match, default_write_file, write_null
  12 bytes: dst_discard_out, dst_discard_in
  55 bytes: nlmsvc_proc_granted_res, nlm4svc_proc_granted_res
  10 bytes: do_posix_clock_nosettime, process_cpu_nsleep_restart, thread_cp=
u_nsleep, thread_cpu_nsleep_restart
  23 bytes: kfifo_free, bio_free_map_data
  34 bytes: part_attr_store, class_device_attr_store
  16 bytes: init_once, fuse_inode_init_once, init_once
  15 bytes: swap_io_context, u32_swap
  33 bytes: __anon_vma_link, anon_vma_link
  218 bytes: __copy_from_user_ll_nozero, __copy_from_user_ll, __copy_to_use=
r_ll
  10 bytes: udp_lib_close, udp_lib_close
  10 bytes: neigh_seq_stop, qdisc_unlock_tree, icmp_xmit_unlock
  11 bytes: pipefs_delete_dentry, sockfs_delete_dentry
  155 bytes: rtattr_strlcpy, nla_strlcpy
  33 bytes: shmem_dir_map, shmem_swp_map
  62 bytes: cap_inode_removexattr, cap_inode_setxattr
  51 bytes: nlmsvc_callback_exit, nlm4svc_callback_exit
  13 bytes: part_release, sk_filter_rcu_free, sk_filter_rcu_free
  15 bytes: nul_refresh, unx_refresh
  13 bytes: put_bus, put_driver
  16 bytes: native_write_idt_entry, native_write_ldt_entry, native_write_gd=
t_entry
  10 bytes: nlmclnt_rpc_release, nlmsvc_callback_release, nlm4svc_callback_=
release
  24 bytes: svcauth_unix_domain_release, svcauth_gss_domain_release
  31 bytes: nlmsvc_proc_null, nlm4svc_proc_null
  35 bytes: nfs_wait_schedule, nfs_wait_bit_interruptible, nfs4_wait_bit_in=
terruptible, rpc_wait_bit_interruptible
  15 bytes: crypto_init_digest_flags, crypto_init_compress_flags
  10 bytes: platform_drv_probe_fail, sock_no_open
  25 bytes: cmp_ex, cmp_node_active_region
  74 bytes: simple_get_bytes, simple_get_bytes
  10 bytes: bad_pipe_r, bad_pipe_w
  95 bytes: nlmsvc_decode_reboot, nlm4svc_decode_reboot
  10 bytes: do_posix_clock_nonanosleep, sock_no_bind, sock_no_connect, sock=
_no_socketpair, sock_no_accept, sock_no_getname, sock_no_ioctl, sock_no_lis=
ten, sock_no_shutdown, sock_no_setsockopt, sock_no_getsockopt, sock_no_send=
msg, sock_no_recvmsg
  27 bytes: xor_128, xor_128

Found 217 instances of 73 duplicated functions
Possible savings: 4034 bytes (of 1460830 total)

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dupfunc.rb"

#!/usr/bin/ruby

# quick script to estimate how space is wasted in an _i386_ binary due to
# duplicate functions
#
# Mitchell Blank Jr <mitch@sfgoth.com> 20060104
#
# Note: since we parse the output of "objdump", it might fail miserably if
# your binutils don't match mine.  This is tested on objdump version
# "2.17.50.0.3-6 20060715" as provided by Fedora Core 6

abort "Usage:  objdump --disassemble vmlinux | #$0" if STDIN.tty?

require 'digest/md5'
HASHFUNC = Digest::MD5
# require 'digest/sha1'
# HASHFUNC = Digest::SHA1

class Func
  attr_reader :name, :bytes, :hash
  @@accumulator = nil
  def initialize(name)
    @name = name
    @bytes = 0
    @@accumulator = HASHFUNC.new
  end
  def <<(hexarr) # add an array of strings (each holding a hex digit) to func
    b = ""
    hexarr.each { |xd| b << xd.hex.chr }
    @bytes += b.length
    @@accumulator << b
  end
  def finish
    @hash = @@accumulator.digest
    @@accumulator = nil
    ### print "Added #@name (#@bytes)\n"
    self
  end
end

funcs = []
curfunc = nil

STDIN.each { |line|
  line.chomp!
  case line
  when /^[[:xdigit:]]{8} <(\S+)>:$/
    # Start of a new function
    funcs << curfunc.finish if curfunc
    curfunc = Func.new($1)
  when /^[[:xdigit:]]{8}:\s*((\s[[:xdigit:]]{2})+)\s.*/
    # An opcode -- add its bytes to the current function
    hex = $1.split
    if (hex.length >= 5 && 
        line =~ /.*\s([[:xdigit:]]{8})\s+<(\w+)(\+0x[[:xdigit:]])?>$/ &&
	curfunc.name != $2)
      # Evil hack -- it seems this opcode references a location outside this
      # function.  For comparison purposes we want to pretend the opcode was
      # referencing the absolute target address.  Otherwise, two identical
      # functions that both do "call otherfunc" will appear to be different
      # because the call opcode will have different relative addresses
      #
      # It's also actually possible to also have false-positives without this
      # transformation: in the kernel sys_send() is a simple wrapper around
      # sys_sendto() and sys_recv() is an identical wrapper around
      # sys_recvfrom().  In my kernel the relative difference in the function
      # addresses are the same so without this hack it thinks that sys_send()
      # and sys_recv() are identical!
      ### print "#{line}\n"
      ### print "BEFORE: #{hex.join(' ')}\n"
      hex[-4, 4] = $1.match("([[:xdigit:]]{2})" * 4).captures.reverse
      ### print "AFTER: #{hex.join(' ')}\n"
    end
    curfunc << hex
  when /.*file format (.*)$/
    abort "can't handle #$1 file format" unless $1 == "elf32-i386"
  when "", /^Disassembly of .*/
    # do nothing
  else
    abort "Can't parse \"#{line}\"!\n"
  end
}
funcs << curfunc.finish if curfunc
curfunc = nil

print "Duplicated functions:\n"
totalbytes = 0
byhash = {}
funcs.each { |func|
  totalbytes += func.bytes
  (byhash[func.hash] ||= []) << func
}
saved = 0
dups = 0
instances = 0
byhash.values.delete_if { |arr| arr.length < 2 }.each { |arr|
  bytes = arr[0].bytes
  arr.collect! { |func| func.name }
  print "  #{bytes} bytes: #{arr.join(', ')}\n"
  dups += 1
  instances += arr.length - 1
  saved += (arr.length - 1) * bytes
}
print "\nFound #{instances} instances of #{dups} duplicated functions\n"
print "Possible savings: #{saved} bytes (of #{totalbytes} total)\n"

--gBBFr7Ir9EOA20Yy--
