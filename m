Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313133AbSDERK1>; Fri, 5 Apr 2002 12:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSDERKJ>; Fri, 5 Apr 2002 12:10:09 -0500
Received: from stinky.trash.net ([195.134.144.50]:28104 "HELO stinky.trash.net")
	by vger.kernel.org with SMTP id <S313133AbSDERJt>;
	Fri, 5 Apr 2002 12:09:49 -0500
Date: Fri, 5 Apr 2002 19:09:46 +0200 (MEST)
From: "Peter H. Ruegg" <lkml+nospam@incense.org>
X-X-Sender: peach@stinky.trash.net
To: linux-kernel@vger.kernel.org
Subject: Problem with NFS-locking
Message-ID: <Pine.GSO.4.42.0204051855540.2556-100000@stinky.trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I use Kernel 2.2.20 on RedHat Systems varying from 6.2 to 7.2.

A few days ago I encountered a problem with our servers: they suddenly
stopped doing nfs-locking properly. We use the Tango2000-Application-
Server which obviously uses file-locking when writing, and though I'm
not happy with that piece of software, I have no oppurtunity to change
it ;-)

However, in the process of tracking down the problem of it crashing I
came accross some messages where it said "it couldn't obtain a write lock".

I then tried to check that, and it doesn't seem to work for me, too :-(
I attached a small program as well as the output of strace which works
on local filesystems but not on NFS-mounted ones.

As glibc seems to route fcntl directly to the kernel, I hope I'm at the
right place here... Is this a bug or am I just a plain stupid programmer?

Thanks for any help!


Peter H. Ruegg

--8<-------------------------------------------------------------------------

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y

--8<-------------------------------------------------------------------------

x.x.x.x:/home/web    /home/web02     nfs
                     rsize=16384,wsize=16384,auto,hard,intr,vers=3   0 0

--8<-------------------------------------------------------------------------

#include <fcntl.h>
#include <unistd.h>
#include <strings.h>
#include <stdio.h>

struct flock* file_lock(short type, short whence) {
        static struct flock ret ;
        ret.l_type = type ;
        ret.l_start = 0;
        ret.l_whence = whence ;
        ret.l_len = 0;
        ret.l_pid = getpid();
        return &ret;
}

int main(int argc, char *argv[]) {

        int     fd;
        int     i;

        if ( argc != 2 )
		{ fprintf(stderr, "Must call with file\n"); exit(1); }

        printf("Trying to open %s  ", argv[1]);

        if ( ( fd = open(argv[1], O_RDWR, 0) ) == -1 ) {
		printf("...failed!\n");
		exit(1);
	}
        printf("...ok!\n");

        printf("File-ID:  %i\n", fd);

        printf("Trying to read-lock file %s  ", argv[1]);

        if ( ( i = fcntl(fd, F_SETLKW, file_lock(F_RDLCK, SEEK_SET)) ) == 0 )
		printf("...ok!\n");
        else printf("...FALSE - %i!\n", i);

}

--8<-------------------------------------------------------------------------

[root@tango02 testlock]# strace ./lock3 /home/web02/incense.org/testlock
execve("./lock3", ["./lock3", "/home/web02/incense.org/testlock"], [/* 28 vars */]) = 0
uname({sys="Linux", node="tango02.incense.org", ...}) = 0
brk(0)                                  = 0x8049934
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x126000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("i686/mmx/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("i686/libc.so.6", O_RDONLY)        = -1 ENOENT (No such file or directory)
open("mmx/libc.so.6", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("libc.so.6", O_RDONLY)             = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=17693, ...}) = 0
old_mmap(NULL, 17693, PROT_READ, MAP_PRIVATE, 3, 0) = 0x127000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\303"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0755, st_size=5723311, ...}) = 0
old_mmap(NULL, 1265288, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x12c000
mprotect(0x258000, 36488, PROT_NONE)    = 0
old_mmap(0x258000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12b000) = 0x258000
old_mmap(0x25d000, 16008, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x25d000
close(3)                                = 0
munmap(0x127000, 17693)                 = 0
fstat64(1, 0x7ffff1a0)                  = -1 ENOSYS (Function not implemented)
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x127000
open("/home/web02/incense.org/testlock", O_RDWR) = 3
write(1, "Trying to open /home/web02/incen"..., 53Trying to open /home/web02/incense.org/testlock  ...ok!
) = 53
write(1, "File-ID:  3\n", 12File-ID:  3
)           = 12
getpid()                                = 4770
fcntl64(0x3, 0x7, 0x8049924, 0x125e6c)  = -1 ENOSYS (Function not implemented)
fcntl(3, F_SETLKW, {type=F_RDLCK, whence=SEEK_SET, start=0, len=0}) = -1 EINVAL (Invalid argument)
write(1, "Trying to read-lock file /home/w"..., 71Trying to read-lock file /home/web02/incense.org/testlock  ...FALSE - -1!
) = 71
munmap(0x127000, 4096)                  = 0
_exit(15)                               = ?


--8<-------------------------------------------------------------------------
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}

