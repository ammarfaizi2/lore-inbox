Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757156AbWK0HFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbWK0HFo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 02:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757160AbWK0HFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 02:05:43 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:53453 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757134AbWK0HFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 02:05:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VwKRWKEJtH2Uqol9XX631KSxbAuK2XIxUci4euZXFnW0xr0Wtfb1CwDNPTEAwrZZzxTAIcu16PK75TzILeXHNwd6Bn6b6WhmEB7DLErK/gZVwckzQsuZjixuFIOcNGsgJcaN2HKAAcOTTZ5nL95XzY5vgNc/COMHx6bZ6VtxjUI=
Date: Mon, 27 Nov 2006 15:58:32 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       viro@zeniv.linux.org.uk
Subject: Re: [PATCH] selinux: fix dentry_open() error check
Message-ID: <20061127065832.GA7125@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	Stephen Smalley <sds@tycho.nsa.gov>,
	James Morris <jmorris@namei.org>, viro@zeniv.linux.org.uk
References: <20061127061648.GA20065@APFDCB5C> <20061127063558.GA6688@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127063558.GA6688@infradead.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 06:35:58AM +0000, Christoph Hellwig wrote:
> On Mon, Nov 27, 2006 at 03:16:48PM +0900, Akinobu Mita wrote:
> > The return value of dentry_open() shoud be checked by IS_ERR().
> 
> first great work finding all these calling convetion mismatches.
> 
> Do you have some tool to find these?

Yes. I have just simple checker using regular expression.
It has the list of function name that need to check IS_ERR().
If there is not IS_ERR() within 3 line after calling the function in that list.
It print file name and line number.

$ find . -name '*.c' -not -name '*.mod.c' -exec checker.py {} \;
./net/bluetooth/rfcomm/tty.c: 264
./net/ipv6/ah6.c: 453
./net/sunrpc/pmap_clnt.c: 297
...

$ cat checker.py
#!/usr/bin/python
import sys
import re

def match_is_err(line):
	if re.search('IS_ERR', line):
		return True
	return False

funcs = [
	'lookup_instantiate_filp',
##	kernel
	'clockevent_set_next_event',
	'clk_get',
	'copy_process',
	'fork_idle',
	'kthread_create',
	'kthread_run',
	'kfifo_init',
	'kfifo_alloc',
	'ptrace_get_task_struct',
	'param_sysfs',
	'__stop_machine_run',

##	mm
	'do_brk',
	'do_mmap',
	'do_mmap_pgoff',
	'do_mremap',
	'follow_huge_addr',
	'mpol_copy',
	'nd_get_link',
	'read_cache_page',
	'read_mapping_page',
	'shmem_file_setup',
	'strndup_user',
	'sys_mremap',
	'__mpol_copy',

##	lib
	'alloc_ts_config',

##	block

##	crypto
	'crypto_alloc_base',
	'crypto_alloc_blkcipher',
	'crypto_alloc_cipher',
	'crypto_alloc_comp',
	'crypto_alloc_hash',
	'crypto_alloc_instance',
	'crypto_alg_mod_lookup',
	'crypto_lookup_template',
	'crypto_spawn_tfm',
	'crypto_get_attr_alg',
	'__crypto_alloc_tfm',

##	ipc
	'load_msg',

##	net
	'addrconf_dst_alloc',
	'ipv6_add_addr',
	'ipv6_renew_options',
	'netlink_getsockbyfilp',
	'rpcauth_create',
	'rpc_get_mount',
	'rpc_lookup_create',
	'skb_gso_segment',
	'skb_segment',
	'xt_find_match',
	'xt_find_table_lock',
	'xt_find_target',
	'__neigh_lookup_errno',

##	security
	'keyring_alloc',
	'key_type_lookup',
	'request_key_auth_new',

##	fs/*.c
	'bio_copy_user'
	'bio_map_kern'
	'bio_map_user'
	'bio_map_user_iov'
	'create_read_pipe',
	'create_write_pipe',
	'd_path',
	'dentry_open',
	'do_kern_mount',
	'ext3_journal_start',
	'ext3_journal_start_sb',
	'ext4_journal_start',
	'ext4_journal_start_sb',
	'filp_open',
	'freeze_bdev',
	'getname',
	'inotify_init',
	'jbd2_journal_start',
	'journal_start',
	'kern_mount',
	'lookup_bdev'
	'lookup_one_len',
	'mb_cache_entry_find_first',
	'mb_cache_entry_find_next',
	'nameidata_to_filp',
	'nd_get_link',
	'open_bdev_excl'
	'open_by_devnum',
	'open_exec',
	'posix_acl_from_xattr',
	'rpc_create',
	'sget',
	'simple_transaction_get',
	'vfs_kern_mount',

##	drivers/base/
	'class_create',
	'class_device_create',
	'device_create',
	'make_class_name',
	'platform_device_register_simple',

##	drivers
	'backlight_device_register',
	'drm_sysfs_device_add',
	'drm_sysfs_create',
	'hwmon_device_register',
	'rtc_device_register',
	'scsi_host_lookup',
	'tty_register_device',
	'__scsi_add_device',

##	misc
	'dma_mark_declared_memory_occupied',
]

prefix = '[^a-zA-Z_.>]'
postfix = '\s*\('

def match_funcs(line):
	if line[0] != '\t': # function declaration
		return False
		
	for func in funcs:
		if re.search(prefix + func + postfix, line):
			return True
	return False

def report(filename, lineno):
	print filename + ": " + str(lineno)

def check(filename):
	match = 0
	exceed = 0
	lineno = 0

	for line in open(filename, "r").readlines():
		lineno += 1

		if match_is_err(line):
			# reset
			match = 0
			exceed = 0

		if match > 0:
			exceed += 1
			if exceed > 3:
				report(filename, match)
				# reset
				match = 0
				exceed = 0
			

		if match_funcs(line) and not match_is_err(line):
			if match > 0:
				report(filename, match)

			# init
			match = lineno
			exceed = 0

	if match > 0:
		report(filename, match)

for arg in sys.argv[1:]:
	check(arg)


> I wonder whether we should have some form of sparse annotation to
> tell that a function returns these kinds of errors and we either
> need to check IS_ERR or returned it again a caller with the same attribute.

I really want this.

