Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSJSTgJ>; Sat, 19 Oct 2002 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265674AbSJSTgJ>; Sat, 19 Oct 2002 15:36:09 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:30468 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S265677AbSJSTf7>; Sat, 19 Oct 2002 15:35:59 -0400
Date: Sat, 19 Oct 2002 15:42:02 -0400
Message-Id: <200210191942.g9JJg2U26376@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-19, Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>   
wrote:   
   
> On Tue, Oct 15, 2002 at 11:44:32PM -0700, Philippe Troin wrote:   
> > > Would it be reasonable to allow non-root processes to chroot(), if   
> > > the chroot syscall also changed the cwd for non-root processes?   
> >    
> > No.   
> >    
> > fd = open("/", O_RDONLY);   
> > chroot("/tmp");   
> > fchdir(fd);   
> >    
> > and you're out of the chroot.   
   
> I see. From my aesthetic, it would make sense for chroots to 'stack',   
> such that once a directory is made the root directory, its '..' entry   
> *always* points to itself, even after another chroot(). That would   
> prevent the above break (you could be outside the new root, but you   
> still couldn't back out past the old root), though perhaps at an   
> unacceptable in complexity.   
   
And not quite enough, if I understand your suggestion properly.  It's not   
necessary above to chroot or fchroot using fd; its existance is enough to  
monkey with things outside/above the chroot jail, which is unacceptable.   
   
> I do like the idea of preventing multiple chroots, as a second option.   
  
That's far from enough though.  You also must consider:  
  
-signals to non-chrooted processes  
-shared memory (maybe obsolete now with shmfs)  
-running a setuid file such as /bin/su which has been hardlinked in by  
  a process outside the jail, reading your bogus passwd file in the jail   
  (collusion/multifactor attack)  
-chmod +s a chrooted file, to be accessed by another, unprivileged UID  
  which is not jailed (collusion/multifactor attack)  
-ptrace non-chrooted processes  
-in addition, for root:  
  -open raw devices / mknod of block and char devices  
  -mount(2)  
  -various capabilities need to be dropped (sysctl, module loading, ...)  
  
Any of these allow a chrooted process to interact too much with the rest  
of the system, if not leading to outright, immediate chroot-breaking.   
Some of them can be protected against without kernel patching, just  
careful policing of chroot usage: don't ever chroot a UID who also has  
processes outside of chroot (or in a different jail); make the parent of  
the chroot dir inaccessible by non-chrooted processes / regular users, 
dont't give write access/directory ownership anywhere under chroot, etc.  
Some can't be made safe(r) w/o help.  
  
I have a patch to do all of the above here (only for 2.2 atm):  
http://www.theaimsgroup.com/~hlein/hap-linux/  
Look for CONFIG_SECURE_CHROOT.  Double chroots are forbidden, but also, a  
warning is printed if a process attempts to chroot with an open fd to a  
directory (I decided against making the chroot call fail, as any software  
buggy enough to chroot with open directory fds is likely to not check the  
return value of chroot(2), and blindly continue on failure--even worse).   
I'd be happy to hear about (and fix ;) anything I've missed.  
  
IIRC, FreeBSD allow a chroot'ed process to chroot again if and only if 
the  
new root is a subdirectory of the initial chroot.  This allows things 
like  
traditional, chrooting anonymous FTP to be run under an initial chroot.    
  
Double-chroot would also be desirable if you wanted to, say, have init  
spawn some kind of supervisory daemon (or just /bin/login on a serial  
port) and then have *everything* else be chrooted, all multiuser daemons,  
etc.  Then a compromise can play all they want in the sandbox; you still  
have an opportunity for integrity checking tools, etc to run in a 
somewhat  
trustworthy environment.  
  
--   
Hank Leininger <hlein@progressive-comp.com>    
     
