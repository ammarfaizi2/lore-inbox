Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266660AbUFWUk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266660AbUFWUk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUFWUk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:40:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48295 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266660AbUFWUib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:38:31 -0400
Date: Wed, 23 Jun 2004 22:38:29 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200406232038.i5NKcTs11770.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: path_resolution.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid repeating the same longish text on the man pages
for many system calls, I wrote a man page path_resolution.2 that
other pages can refer to.

Comments, corrections and additions are welcome.

Andries

PATH_RESOLUTION(2)  Linux Programmer's Manual  PATH_RESOLUTION(2)



NNAAMMEE
       Unix/Linux  path resolution - find the file referred to by
       a filename

DDEESSCCRRIIPPTTIIOONN
       Some Unix/Linux system calls have as parameter one or more
       filenames.   A  filename (or pathname) is resolved as fol­
       lows.


   SStteepp 11:: SSttaarrtt ooff tthhee rreessoolluuttiioonn pprroocceessss
       If the pathname starts with the '/' character, the  start­
       ing  lookup directory is the root directory of the current
       process. (A process inherits its root directory  from  its
       parent.  Usually  this  will  be the root directory of the
       file hierarchy. A process may get a different root  direc­
       tory  by  use  of the cchhrroooott(2) system call. A process may
       get an entirely private namespace in case it - or  one  of
       its  ancestors  -  was  started  by  an  invocation of the
       cclloonnee(2) system call that had the CLONE_NEWNS  flag  set.)
       This handles the '/' part of the pathname.

       If the pathname does not start with the '/' character, the
       starting lookup directory of the resolution process is the
       current  working  directory  of the process. (This is also
       inherited from the parent.  It can be changed  by  use  of
       the cchhddiirr(2) system call.)

       Pathnames  starting  with a '/' character are called abso­
       lute pathnames.  Pathnames not starting  with  a  '/'  are
       called relative pathnames.


   SStteepp 22:: WWaallkk aalloonngg tthhee ppaatthh
       Set  the  current  lookup directory to the starting lookup
       directory.  Now, for each non-final component of the path­
       name,  where  a  component is a substring delimited by '/'
       characters, this component is looked  up  in  the  current
       lookup directory.

       If the process does not have search permission on the cur­
       rent lookup directory, an EACCES error is returned  ("Per­
       mission denied").

       If the component is not found, an ENOENT error is returned
       ("No such file or directory").

       If the component is found, but is neither a directory  nor
       a  symbolic  link,  an  ENOTDIR  error is returned ("Not a
       directory").

       If the component is found and is a directory, we  set  the
       current  lookup directory to that directory, and go to the
       next component.

       If the component is found and is  a  symbolic  link  (sym­
       link),  we first resolve this symbolic link (with the cur­
       rent lookup directory as starting lookup directory).  Upon
       error,  that  error  is  returned.  If the result is not a
       directory, an ENOTDIR error is returned.  If  the  resolu­
       tion of the symlink is successful and returns a directory,
       we set the current lookup directory to that directory, and
       go  to  the next component.  Note that the resolution pro­
       cess here involves recursion.  In  order  to  protect  the
       kernel against stack overflow, and also to protect against
       denial of service, there are limits on the maximum  recur­
       sion  depth,  and  on  the maximum number of symlinks fol­
       lowed. An ELOOP error is  returned  when  the  maximum  is
       exceeded ("Too many levels of symbolic links").


   SStteepp 33:: FFiinndd tthhee ffiinnaall eennttrryy
       The  lookup  of  the  final component of the pathname goes
       just like that of all other components,  as  described  in
       the  previous  step,  with  two differences: (i) the final
       component need not be a directory (at least as far as  the
       path resolution process is concerned - it may have to be a
       directory, or a non-directory, because of the requirements
       of the specific system call), and (ii) it is not necessar­
       ily an error if the component is not found - maybe we  are
       just  creating  it.  The  details  on the treatment of the
       final entry are described in the manual pages of the  spe­
       cific system calls.


   .. aanndd ....
       By  convention,  every  directory  has the entries "." and
       "..", which refer to the directory itself and to its  par­
       ent directory, respectively.

       The path resolution process will assume that these entries
       have their conventional meanings,  regardless  of  whether
       they are actually present in the physical filesystem.

       One  cannot  walk down past the root: "/.." is the same as
       "/".


   MMoouunntt ppooiinnttss
       After a "mount dev  path"  command,  the  pathname  "path"
       refers  to  the  root  of  the filesystem hierarchy on the
       device "dev", and no longer to  whatever  it  referred  to
       earlier.

       One can walk out of a mounted filesystem: "path/.." refers
       to the parent directy of "path", outside of the filesystem
       hierarchy on "dev".


   TTrraaiilliinngg ssllaasshheess
       If a pathname ends in a '/', that forces resolution of the
       preceding component as in Step 2 - it  has  to  exist  and
       resolve  to  a  directory.   Otherwise  a  trailing '/' is
       ignored.  (Or, equivalently, a pathname  with  a  trailing
       '/'  is  equivalent  to the pathname obtained by appending
       '.' to it.)


   FFiinnaall ssyymmlliinnkk
       If the last component of a pathname is  a  symbolic  link,
       then  it  depends  on  the  system  call  whether the file
       referred to will be the symbolic link  or  the  result  of
       path  resolution on its contents.  For example, the system
       call llssttaatt(2) will operate on the symlink,  while  ssttaatt(2)
       operates on the file pointed to by the symlink.


   LLeennggtthh lliimmiitt
       There  is  a maximum length for pathnames. If the pathname
       (or some intermediate pathname  obtained  while  resolving
       symbolic  links)  is  too  long,  an ENAMETOOLONG error is
       returned ("File name too long").


   EEmmppttyy ppaatthhnnaammee
       In the original Unix, the empty pathname referred  to  the
       current  directory.   Nowadays POSIX decrees that an empty
       pathname must not be resolved successfully. Linux  returns
       ENOENT in this case.


   PPeerrmmiissssiioonnss
       The  permission  bits of a file consist of three groups of
       three bits, cf. cchhmmoodd(1) and ssttaatt(2).  The first group  of
       three  is  used  when the effective user ID of the current
       process equals the owner ID of the file. The second  group
       of  three  is  used  when  the group ID of the file either
       equals the effective group ID of the current  process,  or
       is  one of the supplementary group IDs of the current pro­
       cess (as set by sseettggrroouuppss(2)).  When  neither  holds,  the
       third group is used.

       Of the three bits used, the first bit determines read per­
       mission, the second write permission, and the last execute
       permission in caseÂof ordinary files, or search permission
       in case of directories.

       Linux uses the fsuid instead of the effective user  ID  in
       permission  checks.   Ordinarily  the fsuid will equal the
       effective user ID, but the fsuid can  be  changed  by  the
       system call sseettffssuuiidd(2).

       (Here  "fsuid" stands for something like "file system user
       ID".  The concept was required for the implementation of a
       user  space NFS server at a time when processes could send
       a signal to a process with the same effective user ID.  It
       is obsolete now. Nobody should use sseettffssuuiidd(2).)

       Similarly,  Linux  uses the fsgid instead of the effective
       group ID. See sseettffssggiidd(2).



   CCaappaabbiilliittiieess
       If the permission bits of the file deny whatever is asked,
       permission  can  still be granted by the appropriate capa­
       bilities.

       Traditional systems do not use capabilities and root (user
       ID  0) is all-powerful. Such systems are presently handled
       by giving root all capabilities  except  for  CAP_SETPCAP.
       More  precisely, at exec time a process gets all capabili­
       ties  except  CAP_SETPCAP  and   the   five   capabilities
       CAP_CHOWN,      CAP_DAC_OVERRIDE,     CAP_DAC_READ_SEARCH,
       CAP_FOWNER, CAP_FSETID, in case it has zero euid,  and  it
       gets  these  last  five  capabilities  in case it has zero
       fsuid, while all other processes get no capabilities.

       The CAP_DAC_OVERRIDE capability overrides  all  permission
       checking,  but  will only grant execute permission when at
       least one of the three execute permission bits is set.

       The CAP_DAC_READ_SEARCH capability  will  grant  read  and
       search  permission  on directories, and read permission on
       ordinary files.





Linux 2.6.7                 2004-06-21         PATH_RESOLUTION(2)
