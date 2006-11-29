Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967664AbWK2UkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967664AbWK2UkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967661AbWK2UkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:40:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:23958 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S967660AbWK2UkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:40:00 -0500
Date: Wed, 29 Nov 2006 14:40:13 -0600
From: "Bill O'Donnell" <billodo@sgi.com>
To: Chris Friedhoff <chris@friedhoff.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Implement file posix capabilities
Message-ID: <20061129204013.GA7228@sgi.com>
References: <20061127170740.GA5859@sergelap.austin.ibm.com> <20061129112848.8e48267e.chris@friedhoff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129112848.8e48267e.chris@friedhoff.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, running into problems when trying this patch on SLES-10 IA64,
(Linux certify 2.6.18 #2 SMP PREEMPT Wed Nov 29 13:11:28 CST 2006 ia64)

1) replaced the ancient /lib/libcap.so.1.92 with less ancient libcap.so.1.10

2) successfully applied Serge's patch to SLES 2.6.18 sources and rebooted

3) installed Kaigai's userspace tools... no problems evident

4) ran setfcaps to see capabilities... (note Memory fault):

certify:~/libcap-1.10 # setfcaps
usage: setfcaps <capabilities> <file> ...
        cap_chown, cap_dac_override, cap_dac_read_search, cap_fowner
	cap_fsetid, cap_kill, cap_setgid, cap_setuid
	cap_setpcap, cap_linux_immutable,
	cap_net_bind_service, cap_net_broadcast
        cap_net_admin, cap_net_raw, cap_ipc_lock, cap_ipc_owner
	cap_sys_module, cap_sys_rawio, cap_sys_chroot, cap_sys_ptrace
	cap_sys_pacct, cap_sys_admin, cap_sys_boot, cap_sys_nice
	cap_sys_resource, cap_sys_time,
	cap_sys_tty_config, cap_mknod
        cap_lease, cap_audit_write, cap_audit_controlMemory fault

5) straced previous command:

billodo@certify:/> strace -o /tmp/straceout4 setfcaps
billodo@certify:/> cat  /tmp/straceout4
execve("/sbin/setfcaps", ["setfcaps"], [/* 65 vars */]) = 0
brk(0)                                  = 0x6000000000004000
uname({sys="Linux", node="certify", ...}) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=111415, ...}) = 0
mmap(NULL, 111415, PROT_READ, MAP_PRIVATE, 3, 0) = 0x200000000004c000
close(3)                                = 0
open("/lib/libcap.so.1", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\340\25"..., 832) =
832
fstat(3, {st_mode=S_IFREG|0755, st_size=22672, ...}) = 0
mmap(NULL, 85800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0x2000000000068000
madvise(0x2000000000068000, 85800, MADV_SEQUENTIAL|0x1) = 0
mprotect(0x2000000000070000, 49152, PROT_NONE) = 0
mmap(0x200000000007c000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x200000000007c000
close(3)                                = 0
open("/lib/libc.so.6.1", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\3609\2"..., 832) =
832
fstat(3, {st_mode=S_IFREG|0755, st_size=2590313, ...}) = 0
mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2000000000080000
mmap(NULL, 2416624, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0x2000000000084000
madvise(0x2000000000084000, 2416624, MADV_SEQUENTIAL|0x1) = 0
mprotect(0x20000000002bc000, 49152, PROT_NONE) = 0
mmap(0x20000000002c8000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x234000) = 0x20000000002c8000
mmap(0x20000000002d0000, 8176, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000002d0000
close(3)                                = 0
mmap(NULL, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x20000000002d4000
mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x20000000002dc000
munmap(0x200000000004c000, 111415)      = 0
write(2, "usage: setfcaps <capabilities> <"..., 41) = 41
write(2, "\n\tcap_chown", 11)           = 11
write(2, ", cap_dac_override", 18)      = 18
write(2, ", cap_dac_read_search", 21)   = 21
write(2, ", cap_fowner", 12)            = 12
write(2, "\n\tcap_fsetid", 12)          = 12
write(2, ", cap_kill", 10)              = 10
write(2, ", cap_setgid", 12)            = 12
write(2, ", cap_setuid", 12)            = 12
write(2, "\n\tcap_setpcap", 13)         = 13
write(2, ", cap_linux_immutable", 21)   = 21
write(2, ", cap_net_bind_service", 22)  = 22
write(2, ", cap_net_broadcast", 19)     = 19
write(2, "\n\tcap_net_admin", 15)       = 15
write(2, ", cap_net_raw", 13)           = 13
write(2, ", cap_ipc_lock", 14)          = 14
write(2, ", cap_ipc_owner", 15)         = 15
write(2, "\n\tcap_sys_module", 16)      = 16
write(2, ", cap_sys_rawio", 15)         = 15
write(2, ", cap_sys_chroot", 16)        = 16
write(2, ", cap_sys_ptrace", 16)        = 16
write(2, "\n\tcap_sys_pacct", 15)       = 15
write(2, ", cap_sys_admin", 15)         = 15
write(2, ", cap_sys_boot", 14)          = 14
write(2, ", cap_sys_nice", 14)          = 14
write(2, "\n\tcap_sys_resource", 18)    = 18
write(2, ", cap_sys_time", 14)          = 14
write(2, ", cap_sys_tty_config", 20)    = 20
write(2, ", cap_mknod", 11)             = 11
write(2, "\n\tcap_lease", 11)           = 11
write(2, ", cap_audit_write", 17)       = 17
write(2, ", cap_audit_control", 19)     = 19
--- SIGSEGV (Segmentation fault) @ 200000000015ed20 (ffffffffffffffff) ---
+++ killed by SIGSEGV +++
billodo@certify:/>                     

6) probably can't go much beyond (5), as problems likely relate to that
segfault.  Nevertheless, I tried to modify capabities for 
modprobe, yielding the all too familiar error... 

billodo@certify:/> modprobe fuse major-0                            
FATAL: Error inserting fuse (/lib/modules/2.6.18/kernel/fs/fuse/fuse.ko):
Operation not permitted
billodo@certify:/> sudo setfcaps cap_sys_module=ep /sbin/modprobe
/sbin/modprobe: Function not implemented (errno=38)

-Bill


On Wed, Nov 29, 2006 at 11:28:48AM +0100, Chris Friedhoff wrote:
| I use this patch with 2.6.18.3.
| patching: ok
| configuring: ok
| compiling: ok
| installing: ok
| running: ok
| tested with httpd, smbd, nmbd, named, cupsd, ping, traceroute,
| modprobe, traceroute, ntpdate, xinit, killall, eject, dhcpd, route,
| qemu: ok
| I use this patch as documented: http://www.friedhoff.org/fscaps.html
| 
| I also tested the patched kernel with "CONFIG_SECURITY_FS_CAPABILITIES
| is not set" and xinit kills X perfectly, when the GUI is stopped.
| 
| Any other tests that might be helpful?
| 
| The webpage is updated.
| 
| Chris
| 
| 
| On Mon, 27 Nov 2006 11:07:40 -0600
| "Serge E. Hallyn" <serue@us.ibm.com> wrote:
| 
| > From: Serge E. Hallyn <serue@us.ibm.com>
| > Subject: [PATCH 1/1] Implement file posix capabilities
| > 
| > Implement file posix capabilities.  This allows programs to be given a
| > subset of root's powers regardless of who runs them, without having to use
| > setuid and giving the binary all of root's powers.
| > 
| > This version works with Kaigai Kohei's userspace tools, found at
| > http://www.kaigai.gr.jp/index.php.  For more information on how to use this
| > patch, Chris Friedhoff has posted a nice page at
| > http://www.friedhoff.org/fscaps.html.
| > 
| > Changelog:
| > 	Nov 27:
| > 	Incorporate fixes from Andrew Morton
| > 	(security-introduce-file-caps-tweaks and
| > 	security-introduce-file-caps-warning-fix)
| > 	Fix Kconfig dependency.
| > 	Fix change signaling behavior when file caps are not compiled in.
| 
| - snip -
| 
| --------------------
| Chris Friedhoff
| chris@friedhoff.org
| -
| To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bill O'Donnell
SGI
billodo@sgi.com
