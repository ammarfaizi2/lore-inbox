Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273121AbRIJApl>; Sun, 9 Sep 2001 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273119AbRIJApc>; Sun, 9 Sep 2001 20:45:32 -0400
Received: from d117.dhcp212-140.cybercable.fr ([212.198.140.117]:37210 "HELO
	pridamix.molteni.net") by vger.kernel.org with SMTP
	id <S273117AbRIJApY>; Sun, 9 Sep 2001 20:45:24 -0400
Message-ID: <3B9C0D36.3EA20B24@molteni.net>
Date: Mon, 10 Sep 2001 02:45:42 +0200
From: Olivier Molteni <olivier@molteni.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Francis Galiegue <fg@mandrakesoft.com>
Subject: Oops NFS Locking in 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Francis, I'm working with Damien Clermonte on this NFS problem, as I saw
that you put Damien in CC of your last posting, I want to send you this
copy.
If you are bothered by this mail, please excuse me and discard it. I
will not continue to CC you if you do not explicitly told me to do so.

I have new elements about the Oops described in my precedent post:


Problem: When doing several lock RW AND RO on NFS with 2.4.x by several
concurent process on the same file, kernel Oops:

- I have reproduct this on two NFS servers (Netapp F820C & Linux 2.4.x)
So, it shows that problem is not on the server side (not the Netapp).
- I have tested several version of the client with NFSV2 & V3: Linux
2.4.9, 2.4.9-ac9, 2.4.9-ac10, 2.4.7 and 2.4.4 The problem is the same.
- I have tryed several patches by Francis Galiegue fixing non tested
allocation in the locks code, but without success on this particular
problem.
- I have tested several hardware: Gigabyte PIII 900Ghz, Toshiba PIII
700Ghz & Vmware => ever again the same symptoms
- Note that with NFS Client on Linux 2.2.x (tested x=19 & 14) no Oops
but process block on IO (D) after about 300/400 locks, this is not
better, just different


Searching in the code I found that the Oops is caused by the call of
locks_delete_lock in fs/locks.c with a NULL value for *thisfl_p
- I tryed to test it and return if NULL:
        if (! fl) {
                printk(KERN_ERR "locks_delete_lock: fl = NULL !!\n") ;
                return ;
        }
It is fixing the Oops, but not the problem because the lock remain and
the process stay in IO Blocking state (Like in kernels 2.2.x, a return
is placed in a similar function)

- Searching agin, I found that the problem occurs when calling the
function from locks_unlock_delete() in fs/locks.c
just before calling the 'file_operation'  lock(fl->fl_file, F_SETLK,
fl); *thisfl_p contain a value and after too (obviously) BUT, when doing
the Oops, *thisfl_p is NULL after this call !!
The more suspect to me, is that *thisfl_p is NEVER passed nor affected
in the procedure !
=> What I call lock() is in fact the function nfs_lock() in
fs/nfs/file.c wich is affected to the struct file_operation at the begin
of file.c

- By making traces on nfs_lock and locks_unlock_delete (printk !) I saw
2 things:
1) Certain times it seems that the fuction is called simultanously by
many sources; it is possible that something is not reentrant...
2) I have one trace (Only one because I do this particular test only one
time, so I dont know if it is systematic) where 13 secs before the
problem occures the fuction nfs_lock never return...
the trace is normaly like that:

    Sep  9 16:03:13 mx00 kernel: locks_unlock_delete: ours is set (537).

    Sep  9 16:03:13 mx00 kernel: nfs_lock: ours is set.
    Sep  9 16:03:13 mx00 kernel: NFS: nfs_lock(f=   8/6922176, t=2,
fl=1, r=0:9223372036854775807)
    Sep  9 16:03:13 mx00 kernel: nfs_lock: ours is set.
    Sep  9 16:03:13 mx00 kernel: NFS: nfs_lock(f=   8/7666850, t=1,
fl=1, r=0:9223372036854775807)
    Sep  9 16:03:13 mx00 kernel: nfs_lock: out F (537).
    Sep  9 16:03:14 mx00 kernel: locks_unlock_delete: ours is set (538).

    Sep  9 16:03:14 mx00 kernel: nfs_lock: ours is set.
... And so on
"ours" is a global that I increment eac time we call nfs_lock...

The suspect trace is this one:

    Sep  9 16:03:14 mx00 kernel: locks_unlock_delete: ours is set (539).

    Sep  9 16:03:14 mx00 kernel: nfs_lock: ours is set.
    Sep  9 16:03:14 mx00 kernel: NFS: nfs_lock(f=   8/1082753, t=2,
fl=1, r=0:9223372036854775807)
    / *********     We NEVER return ********/
    Sep  9 16:03:14 mx00 kernel: locks_unlock_delete: ours is set (540).

I never found again "out F (539) in the whole log...
But few seconds after...

    Sep  9 16:03:21 mx00 kernel: locks_unlock_delete: ours is set (635).

    Sep  9 16:03:21 mx00 kernel: nfs_lock: ours is set.
    Sep  9 16:03:21 mx00 kernel: NFS: nfs_lock(f=   8/6922176, t=2,
fl=1, r=0:9223372036854775807)
    Sep  9 16:03:21 mx00 kernel: nfs_lock: out F (635).
    Sep  9 16:03:21 mx00 kernel: locks_unlock_delete: fl = NULL D !!
    Sep  9 16:03:21 mx00 kernel: locks_unlock_delete: *thisfl_p = NULL E
!!
    Sep  9 16:03:21 mx00 kernel: locks_delete_lock: fl = NULL (called by
locks_unlock_delete)!!

And after about 1 min no more locks where posible on the file, the last
was

    Sep  9 16:04:19 mx00 kernel: nfs_lock: out F (641).

I'm not a developper, I'm a system guys, I'm afraid I'm really lost in
the code... If somebody can help me....

There is the initial Oops screen and a ksymoops (already posted
yesterday)
===================================================================
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c013d6e7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d6e7>]
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7d77960
esi: 00000004   edi: 00000001   ebp: bfffdb2c   esp: c626ff74
ds: 0018   es: 0018   ss: 0018
Process cyrdeliver (pid: 15652, stackpage=c626f000)
Stack: f7d77960 ed00eac0 c013f048 f7d77960 00000000 ecc895c0 00000000
c012e3f5
       ecc895c0 ed00eac0 00000000 ecc895c0 00000000 ecc895c0 bfffbb2c
c012e447
       ecc895c0 ed00eac0 c626e000 c0106d2b 00000004 00000004 bfffcb2c
bfffbb2c
Call Trace: [<c013f048>] [<c012e3f5>] [<c012e447>] [<c0106d2b>]

Code: 8b 03 89 02 c7 03 00 00 00 00 8b 56 04 8b 43 04 89 50 04 89
====================================================================

====================================================================
ksymoops 2.3.4 on i686 2.4.9-ac10.  Options used
     -v vmlinux.1 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map.1 (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000000
c013d6e7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d6e7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7d77960
esi: 00000004   edi: 00000001   ebp: bfffdb2c   esp: c626ff74
ds: 0018   es: 0018   ss: 0018
Process cyrdeliver (pid: 15652, stackpage=c626f000)
Stack: f7d77960 ed00eac0 c013f048 f7d77960 00000000 ecc895c0 00000000
c012e3f5
       ecc895c0 ed00eac0 00000000 ecc895c0 00000000 ecc895c0 bfffbb2c
c012e447
       ecc895c0 ed00eac0 c626e000 c0106d2b 00000004 00000004 bfffcb2c
bfffbb2c
Call Trace: [<c013f048>] [<c012e3f5>] [<c012e447>] [<c0106d2b>]
Code: 8b 03 89 02 c7 03 00 00 00 00 8b 56 04 8b 43 04 89 50 04 89

>>EIP; c013d6e7 <locks_delete_lock+b/e8>   <=====
Trace; c013f048 <locks_remove_posix+58/6c>
Trace; c012e3f5 <filp_close+55/64>
Trace; c012e447 <sys_close+43/54>
Trace; c0106d2b <system_call+33/38>
Code;  c013d6e7 <locks_delete_lock+b/e8>
00000000 <_EIP>:
Code;  c013d6e7 <locks_delete_lock+b/e8>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c013d6e9 <locks_delete_lock+d/e8>
   2:   89 02                     mov    %eax,(%edx)
Code;  c013d6eb <locks_delete_lock+f/e8>
   4:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c013d6f1 <locks_delete_lock+15/e8>
   a:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c013d6f4 <locks_delete_lock+18/e8>
   d:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c013d6f7 <locks_delete_lock+1b/e8>
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013d6fa <locks_delete_lock+1e/e8>
  13:   89 00                     mov    %eax,(%eax)
====================================================================



The piece of code doing the Oops follows:
Just pass it a NFS homed file in argument and wait about 60 secs
(depending of the machine ~3min on vmware on a PIII 700)
It is important to do read AND write locking simultanously by multiple
(4 in this case) process.
--------
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>


#define MAX     1000
#define CLEAN   19

int
main(int argc, char **argv)
{
        struct flock    fl[MAX];
        int             fd[MAX];
        char            *fname;
        int             c ;
        int             cv ;
        pid_t           pid ;

        if (argc != 2) {
                printf ("FILE NAME STUPID !!\n") ;
                exit (1) ;
        }
        fname = argv[1];


        /* 4 players insert coins !! */
        fork () ;
        fork () ;

        pid = getpid() ;

        for (;;) {
                for (cv=c=0; c<MAX;c++) {

                        fl[c].l_whence = 0 ;
                        fl[c].l_start = 0 ;
                        fl[c].l_len = 0 ;


                        if (c % 2) {
                                if ((fd[c] = open(fname, O_RDWR, 0644))
< 0) {
                                        printf ("%d: OPEN RDWR Koin\n",
pid) ;
                                }
                                fl[c].l_type = F_WRLCK;
                        } else {
                                if ((fd[c] = open(fname, O_RDONLY,
0644)) < 0) {
                                        printf ("%d: OPEN RDWR Koin\n",
pid) ;
                                }
                                fl[c].l_type = F_RDLCK;
                        }
                        if (fcntl(fd[c], F_SETLKW, &(fl[c])) < 0) {
                                printf ("%d: FCNTL Koin\n", pid) ;
                        } else {
                                printf ("%d (%d) OK....\n", pid, c) ;
                        }

                        if (c % CLEAN) {
                                do {
                                        close (fd[cv]) ;
                                        cv++ ;
                                } while (! (cv % CLEAN)) ;
                        }
                }
                while (cv < c) {
                        close (fd[cv]) ;
                        cv++ ;
                }
        }

}
--------

