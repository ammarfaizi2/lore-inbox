Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132848AbRDDPrL>; Wed, 4 Apr 2001 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132846AbRDDPrC>; Wed, 4 Apr 2001 11:47:02 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38916 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132844AbRDDPqs>; Wed, 4 Apr 2001 11:46:48 -0400
Date: Wed, 4 Apr 2001 17:46:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Subject: x86_64 syscall numbering
Message-ID: <20010404174602.B20911@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently rewrote the syscall numbering for the x86_64 platform to optimize it
at the cacheline usage level. If somebody wants to overview the numbering and
give feedback or find something better that's welcome. We know we'll break the
kernel API still at least once. I choosed the numbering in function of tpcc
kernel profiling info with popular DBMS and strace output of some network and
desktop application.

Side note: the gettimeofday(2) and time(2) are implemented as vsyscalls. Below
you find the gettimeofday syscall only because it will be used in the asymetric MP
where there's no way to make it working at the userspace level (not even with
per-cpu paging tricks, while with per-cpu paging tricks we could make getpid
working fine because that would be an atomic read only but I preferred to avoid
such a relevant complexity to optimize getpid that should never run during
production anyways). Only in the asymetric MP case the vgettimeofday will
redirect to the gettimeofday syscall without glibc and userspace noticing that
(so all SMP/UP machines won't need to use such syscall).

Thanks.

/* at least 8 syscall per cacheline */
#define __NR_read                                0
#define __NR_write                               1
#define __NR_open                                2
#define __NR_close                               3
#define __NR_stat                                4
#define __NR_fstat                               5
#define __NR_lstat                               6
#define __NR_poll                                7

#define __NR_lseek                               8
#define __NR_mmap                                9
#define __NR_mprotect                           10
#define __NR_munmap                             11
#define __NR_brk                                12
#define __NR_rt_sigaction                       13
#define __NR_rt_sigprocmask                     14
#define __NR_rt_sigreturn                       15

#define __NR_ioctl                              16
#define __NR_pread                              17
#define __NR_pwrite                             18
#define __NR_readv                              19
#define __NR_writev                             20
#define __NR_access                             21
#define __NR_pipe                               22
#define __NR_select                             23

#define __NR_sched_yield                        24
#define __NR_mremap                             25
#define __NR_msync                              26
#define __NR_mincore                            27
#define __NR_madvise                            28
#define __NR_shmget                             29
#define __NR_shmat                              30
#define __NR_shmctl                             31

#define __NR_dup                                32
#define __NR_dup2                               33
#define __NR_pause                              34
#define __NR_nanosleep                          35
#define __NR_getitimer                          36
#define __NR_alarm                              37
#define __NR_setitimer                          38
#define __NR_getpid                             39

#define __NR_sendfile                           40
#define __NR_socket                             41
#define __NR_connect                            42
#define __NR_accept                             43
#define __NR_sendto                             44
#define __NR_recvfrom                           45
#define __NR_sendmsg                            46
#define __NR_recvmsg                            47

#define __NR_shutdown                           48
#define __NR_bind                               49
#define __NR_listen                             50
#define __NR_getsockname                        51
#define __NR_getpeername                        52
#define __NR_socketpair                         53
#define __NR_setsockopt                         54
#define __NR_getsockopt                         55

#define __NR_clone                              56
#define __NR_fork                               57
#define __NR_vfork                              58
#define __NR_execve                             59
#define __NR_exit                               60
#define __NR_wait4                              61
#define __NR_kill                               62
#define __NR_uname                              63

#define __NR_semget                             64
#define __NR_semop                              65
#define __NR_semctl                             66
#define __NR_shmdt                              67
#define __NR_msgget                             68
#define __NR_msgsnd                             69
#define __NR_msgrcv                             70
#define __NR_msgctl                             71

#define __NR_fcntl                              72
#define __NR_flock                              73
#define __NR_fsync                              74
#define __NR_fdatasync                          75
#define __NR_truncate                           76
#define __NR_ftruncate                          77
#define __NR_getdents                           78
#define __NR_getcwd                             79

#define __NR_chdir                              80
#define __NR_fchdir                             81
#define __NR_rename                             82
#define __NR_mkdir                              83
#define __NR_rmdir                              84
#define __NR_creat                              85
#define __NR_link                               86
#define __NR_unlink                             87

#define __NR_symlink                            88
#define __NR_readlink                           89
#define __NR_chmod                              90
#define __NR_fchmod                             91
#define __NR_chown                              92
#define __NR_fchown                             93
#define __NR_lchown                             94
#define __NR_umask                              95

#define __NR_gettimeofday                       96
#define __NR_getrlimit                          97
#define __NR_getrusage                          98
#define __NR_sysinfo                            99
#define __NR_times                             100
#define __NR_ptrace                            101
#define __NR_getuid                            102
#define __NR_syslog                            103

/* at the very end the stuff that never runs during the benchmarks */
#define __NR_getgid                            104
#define __NR_setuid                            105
#define __NR_setgid                            106
#define __NR_geteuid                           107
#define __NR_getegid                           108
#define __NR_setpgid                           109
#define __NR_getppid                           110
#define __NR_getpgrp                           111

#define __NR_setsid                            112
#define __NR_setreuid                          113
#define __NR_setregid                          114
#define __NR_getgroups                         115
#define __NR_setgroups                         116
#define __NR_setresuid                         117
#define __NR_getresuid                         118
#define __NR_setresgid                         119

#define __NR_getresgid                         120
#define __NR_getpgid                           121
#define __NR_setfsuid                          122
#define __NR_setfsgid                          123
#define __NR_getsid                            124
#define __NR_capget                            125
#define __NR_capset                            126

#define __NR_rt_sigpending                     127
#define __NR_rt_sigtimedwait                   128
#define __NR_rt_sigqueueinfo                   129
#define __NR_rt_sigsuspend                     130
#define __NR_sigaltstack                       131
#define __NR_utime                             132
#define __NR_mknod                             133

#define __NR_uselib                            134
#define __NR_personality                       135

#define __NR_ustat                             136
#define __NR_statfs                            137
#define __NR_fstatfs                           138
#define __NR_sysfs                             139

#define __NR_getpriority                       140
#define __NR_setpriority                       141
#define __NR_sched_setparam                    142
#define __NR_sched_getparam                    143
#define __NR_sched_setscheduler                144
#define __NR_sched_getscheduler                145
#define __NR_sched_get_priority_max            146
#define __NR_sched_get_priority_min            147
#define __NR_sched_rr_get_interval             148

#define __NR_mlock                             149
#define __NR_munlock                           150
#define __NR_mlockall                          151
#define __NR_munlockall                        152

#define __NR_vhangup                           153

#define __NR_modify_ldt                        154

#define __NR_pivot_root                        155

#define __NR__sysctl                           156

#define __NR_prctl                             157
#define __NR_arch_prctl                        158

#define __NR_adjtimex                          159

#define __NR_setrlimit                         160

#define __NR_chroot                            161

#define __NR_sync                              162

#define __NR_acct                              163

#define __NR_settimeofday                      164

#define __NR_mount                             165
#define __NR_umount2                           166

#define __NR_swapon                            167
#define __NR_swapoff                           168

#define __NR_reboot                            169

#define __NR_sethostname                       170
#define __NR_setdomainname                     171

#define __NR_iopl                              172
#define __NR_ioperm                            173

#define __NR_create_module                     174
#define __NR_init_module                       175
#define __NR_delete_module                     176
#define __NR_get_kernel_syms                   177
#define __NR_query_module                      178

#define __NR_quotactl                          179

#define __NR_nfsservctl                        180

#define __NR_getpmsg                           181
#define __NR_putpmsg                           182

#define __NR_afs_syscall                       183

#define __NR_syscall_max __NR_afs_syscall

Andrea
