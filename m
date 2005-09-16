Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbVIPS0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbVIPS0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbVIPS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:26:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34690 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161236AbVIPS0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:26:25 -0400
Date: Fri, 16 Sep 2005 11:26:20 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 10/10] vfs: shared subtree documentation 
Message-ID: <20050916182620.GA28560@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Complete description of shared subtrees.

Signed by Ram Pai (linuxram@us.ibm.com)

 Documentation/sharedsubtree.txt | 1015 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1015 insertions(+)

Index: 2.6.13.sharedsubtree/Documentation/sharedsubtree.txt
===================================================================
--- /dev/null
+++ 2.6.13.sharedsubtree/Documentation/sharedsubtree.txt
@@ -0,0 +1,1015 @@
+Shared Subtrees
+---------------
+
+Contents:
+
+	1) Overview
+	2) Features
+	3) smount command
+	4) Use-case
+	5) Detailed semantics
+	6) Quiz
+	7) FAQ
+	8) Bugs
+	9) Implementation
+
+
+1) Overview
+-----------
+
+Consider the following situation:
+
+A process wants to clone its own namespace, but still wants to access the CD
+that got mounted recently.  Shared subtree semantics provide the necessary
+mechanism to accomplish the above.
+
+It provides the necessary building blocks for features like per-user-namespace
+and versioned filesystem.
+
+2) Features
+-----------
+
+Shared subtree provides four different flavors of mounts; struct vfsmount to be
+precise
+
+	a. shared mount
+	b. slave mount
+	c. private mount
+	d. unclonable mount
+
+
+2a) A shared mount can be replicated to as many mountpoints and all the
+replicas continue to be exactly same.
+
+	Here is an example:
+
+	Lets say /mnt has a mount that is shared.
+	mount --make-shared /mnt
+
+	note: mount command does not yet support the --make-shared flag.
+	I have included a small C program which does the same by executing
+	'smount /mnt shared'
+
+	#mount --bind /mnt /tmp
+	The above command replicates the mount at /mnt to the mountpoint /tmp
+	and the contents of both the mounts remain identical.
+
+	#ls /mnt
+	a b c
+
+	#ls /tmp
+	a b c
+
+
+	Now lets say we mount a device at /tmp/a
+	#mount /dev/sd0  /tmp/a
+
+	#ls /tmp/a
+	t1 t2 t2
+
+	#ls /mnt/a
+	t1 t2 t2
+
+	Note that the mount has propagated to the mount at /mnt as well.
+
+	And the same is true even when /dev/sd0 is mounted on /mnt/a. The
+	contents will be visible under /tmp/a too.
+
+
+2b) A slave mount is like a shared mount except that mount and umount events
+	only propagate towards it.
+
+	All slave mounts have a master mount which is a shared mount.
+
+	Here is an example:
+
+	Lets say /mnt has a mount that is shared.
+	#mount --make-shared /mnt
+
+	Lets bind mount /mnt to /tmp
+	#mount --bind /mnt /tmp
+
+	the new mount at /tmp is also a shared mount and it is a replica of
+	the mount at /mnt.
+
+	Now lets make the mount at /tmp a slave of /mnt
+	#mount --make-slave /tmp
+	[or smount /tmp slave]
+
+	lets mount /dev/sd0 on /mnt/a
+	#mount /dev/sd0 /mnt/a
+
+	#ls /mnt/a
+	t1 t2 t3
+
+	#ls /tmp/a
+	t1 t2 t3
+
+	Note the mount event has propagated to the mount at /tmp
+
+	However lets see what happens if we mount something on the mount at /tmp
+
+	#mount /dev/sd1 /tmp/b
+
+	#ls /tmp/b
+	s1 s2 s3
+
+	#ls /mnt/b
+
+	Note how the mount event has not propagated to the mount at
+	/mnt
+
+
+2c) A private mount does not forward or receive propagation.
+
+	This is the mount we are familiar with. Its the default type.
+
+
+2d) A unclonable mount is a unreplicable private mount
+
+	lets say we have a mount at /mnt
+	and we make is unclonable
+
+	#mount --make-unclonable /mnt
+	 [ smount /mnt  unclonable ]
+
+	 Lets try to bind mount this mount somewhere else.
+	 # mount --bind /mnt /tmp
+	 mount: wrong fs type, bad option, bad superblock on /mnt,
+	        or too many mounted file systems
+
+	Replicating a unclonable mount is a invalid operation.
+
+
+3) smount command
+
+	Currently the mount command is not aware of shared subtree features.
+	Work is in progress to add the support in mount( util-linux package).
+	Till then use the following program.
+
+	------------------------------------------------------------------------
+	//
+	//this code was developed my Miklos Szeredi <miklos@szeredi.hu>
+	//and modified by Ram Pai <linuxram@us.ibm.com>
+	// sample usage:
+	//              smount /tmp shared
+	//
+	#include <stdio.h>
+	#include <stdlib.h>
+	#include <unistd.h>
+	#include <sys/mount.h>
+	#include <sys/fsuid.h>
+
+	#ifndef MS_REC
+	#define MS_REC		0x4000	/* 16384: Recursive loopback */
+	#endif
+
+	#ifndef MS_SHARED
+	#define MS_SHARED		1<<20	/* Shared */
+	#endif
+
+	#ifndef MS_PRIVATE
+	#define MS_PRIVATE		1<<18	/* Private */
+	#endif
+
+	#ifndef MS_SLAVE
+	#define MS_SLAVE		1<<19	/* Slave */
+	#endif
+
+	#ifndef MS_UNCLONE
+	#define MS_UNCLONE		1<<17	/* UNCLONE */
+	#endif
+
+	int main(int argc, char *argv[])
+	{
+		int type;
+		if(argc != 3) {
+			fprintf(stderr, "usage: %s dir "
+			"<rshared|rslave|rprivate|runclonable|shared|slave"
+			"|private|unclonable>\n" , argv[0]);
+			return 1;
+		}
+
+		fprintf(stdout, "%s %s %s\n", argv[0], argv[1], argv[2]);
+
+		if (strcmp(argv[2],"rshared")==0)
+			type=(MS_SHARED|MS_REC);
+		else if (strcmp(argv[2],"rslave")==0)
+			type=(MS_SLAVE|MS_REC);
+		else if (strcmp(argv[2],"rprivate")==0)
+			type=(MS_PRIVATE|MS_REC);
+		else if (strcmp(argv[2],"runclonable")==0)
+			type=(MS_UNCLONE|MS_REC);
+		else if (strcmp(argv[2],"shared")==0)
+			type=MS_SHARED;
+		else if (strcmp(argv[2],"slave")==0)
+			type=MS_SLAVE;
+		else if (strcmp(argv[2],"private")==0)
+			type=MS_PRIVATE;
+		else if (strcmp(argv[2],"unclonable")==0)
+			type=MS_UNCLONE;
+		else {
+			fprintf(stderr, "invalid operation: %s\n", argv[2]);
+			return 1;
+		}
+		setfsuid(getuid());
+		if(mount("", argv[1], "ext2", type, "") == -1) {
+			perror("mount");
+			return 1;
+		}
+		return 0;
+	}
+	-----------------------------------------------------------------------
+
+	Copy the above code snippet into smount.c
+	gcc -o smount smount.c
+
+
+	(i) To mark all the mounts under /mnt as shared execute the following
+	command:
+
+	 	smount /mnt rshared
+		the corresponding syntax planned for mount command is
+		mount --make-rshared /mnt
+
+	    just to mark a mount /mnt as shared, execute the following
+	    command:
+	 	smount /mnt shared
+		the corresponding syntax planned for mount command is
+		mount --make-shared /mnt
+
+	(ii) To mark all the shared mounts under /mnt as slave execute the
+	following
+
+	     command:
+		smount /mnt rslave
+		the corresponding syntax planned for mount command is
+		mount --make-rslave /mnt
+
+	    just to mark a mount /mnt as slave, execute the following
+	    command:
+	 	smount /mnt slave
+		the corresponding syntax planned for mount command is
+		mount --make-slave /mnt
+
+	(iii) To mark all the mounts under /mnt as private execute the
+	following command:
+
+		smount /mnt rprivate
+		the corresponding syntax planned for mount command is
+		mount --make-rprivate /mnt
+
+	    just to mark a mount /mnt as private, execute the following
+	    command:
+	 	smount /mnt private
+		the corresponding syntax planned for mount command is
+		mount --make-private /mnt
+
+	      NOTE: by default all the mounts are created as private. But if
+	      you want to change some shared/slave/unclonable  mount as
+	      private at a later point in time, this command can help.
+
+	(iv) To mark all the mounts under /mnt as unclonable execute the
+	following
+
+	     command:
+		smount /mnt runclonable
+		the corresponding syntax planned for mount command is
+		mount --make-runclonable /mnt
+
+	    just to mark a mount /mnt as unclonable, execute the following
+	    command:
+	 	smount /mnt unclonable
+		the corresponding syntax planned for mount command is
+		mount --make-unclonable /mnt
+
+
+
+4) Use cases
+------------
+
+	A) A process wants to clone its own namespace, but still wants to
+	access the CD that got mounted recently.
+
+	Solution:
+
+	The system administrator can make the mount at /cdrom shared
+	mount --bind /cdrom /cdrom
+	mount --make-shared /cdrom
+
+	Now any process that clone off a new namespace will have a mount
+	at /cdrom which is a replica of the same mount in the parent namespace.
+
+	So when a CD is inserted and mounted at /cdrom that mount gets
+	propagated to the other mount at /cdrom in all the other clone
+	namespaces.
+
+	B) A process wants its mounts invisible to any other process, but
+	still be able to see the other system mounts.
+
+	Solution:
+
+	To begin with the administrator can mark the entire mount tree
+	as shareable.
+
+	mount --make-rshared /
+
+	A new process can clone off a new namespace. And mark some part of
+	its namespace as slave
+
+	mount --make-rslave /myprivatetree
+
+	Hence forth any mounts within the /myprivatetree done by the process
+	will not show up in any other namespace. However mounts done in the
+	parent namespace under /myprivatetree still shows up in the
+	process's namespace.
+
+
+	Apart from the above semantics this feature provides the building
+	blocks to solve the following problems:
+
+	C)  Per-user namespace
+	The above semantics allows a way to share mounts across namespaces.
+	But namespaces are associated with processes. If namespaces are made
+	first class objects with user API to associate/disassociate a namespace
+	with userid, then each user could have his/her own namespace and tailor
+	it to his/her requirements. Offcourse its needs support from PAM.
+
+	D)  Versioned files
+
+	If the entire mount tree is visible at multiple locations, then a
+	underlying versioning file system can return different version of the
+	file depending on the path used to access that file.
+
+	An example is:
+
+	mount --make-shared /
+	mount --rbind / /view/v1
+	mount --rbind / /view/v2
+	mount --rbind / /view/v3
+	mount --rbind / /view/v4
+
+	and if at /usr there is a versioning filesystem mounted, that mount
+	appears at /view/v1/usr, /view/v2/usr, /view/v3/usr and /view/v4/usr
+	too
+
+	A user can request v3 version of the file /usr/fs/namespace.c by
+	accessing /view/v3/usr/fs/namespace.c . The underlying versioning
+	filesystem can then decipher that v3 version of the filesystem is being
+	requested and return the corresponding inode.
+
+	E)  Information leakage
+
+	Many programs leave garbage in /tmp and other directories which
+	other users on the system can observe.(covert channels?)
+
+	The way to solve this is to have per-process-namespace and have
+	unclonable mounts at /tmp for each namespaces.
+
+
+
+5) Detailed semantics:
+-------------------
+	The section below explains the detailed semantics of
+	bind, rbind, move, mount, umount and clone-namespace operations.
+
+5A) Bind semantics
+
+	Consider the following command
+
+	mount --bind A/a  B/b
+
+	where 'A' is the source mount, 'a' is the dentry in the mount 'A', 'B'
+	is the destination mount and 'b' is the dentry in the destination mount.
+
+	The outcome depends on the type of mount of 'A' and 'B'. The table
+	below contains quick reference.
+     --------------------------------------------------------------------
+     |                          BIND MOUNT OPERATION                    |
+     |******************************************************************|
+     |dest(B)-->|  shared       |       private  |  slave   |unclonable |
+     | source(A)|               |                |          |           |
+     |   |      |               |                |          |           |
+     |   v      |               |                |          |           |
+     |******************************************************************|
+     |          |               |                |          |           |
+     |  shared  | shared        |     shared     |shared    |shared     |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     | private  | shared        |      private   | private  | private   |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     | slave    | shared        |      slave     | slave    | slave     |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     |unclonable| invalid       |      invalid   | invalid  | invalid   |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     ********************************************************************
+
+     	Details follow:
+
+	1. 'A' is a private mount and 'B' is a private mount. A new mount 'C'
+	which is clone of 'A', is created. Its root dentry is 'a'. 'C' is
+	mounted on mount 'B' at dentry 'b'.
+
+	2. 'A' is a shared mount and 'B' is a private mount. A new mount 'C'
+	which is a clone of 'A' is created. Its root dentry is 'a'. 'C' is
+	mounted on mount 'B' at dentry 'b'. Also 'C' is set for propagation
+	with 'A'.  In other words 'A' and 'C' propagate to each other.
+
+	3. 'A' is a slave mount of mount 'Z' and 'B' is a private mount. A new
+	mount 'C' which is a clone of 'A' is created. Its root dentry is 'a'.
+	'C' is mounted on mount 'B' at dentry 'b'. Also 'C' is set as a slave
+	mount of 'Z'. In other words 'A' and 'C' are both slave mounts of 'Z'.
+	All mount/unmount events on 'Z' propagates to 'A' and 'C'. But
+	mount/unmount on 'A' does not propagate anywhere else. Similarly
+	mount/unmount on 'C' does not propagate anywhere else.
+
+	4. 'A' is a unclonable mount and 'B' is a private mount. This is a
+	invalid operation. A unclonable mount cannot be bind mounted.
+
+	5. 'A' is a private mount and 'B' is a shared mount. A new mount 'C'
+	which is clone of 'A', is created. Its root dentry is 'a'. 'C' is
+	mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
+	are created and mounted at the dentry 'b' on all mounts where 'B'
+	propagates to. A new propagation tree is set containing all new mounts
+	'C1', .., 'Cn' exactly with the same configuration as the propagation
+	tree of 'B'.
+
+	6. 'A' is a shared mount and 'B' is a shared mount. A new mount 'C'
+	which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
+	mounted on mount 'B' at dentry 'b'. Also new mount 'C1', 'C2', 'C3' ...
+	are created and mounted at the dentry 'b' on all mounts where 'B'
+	propagates to. A new propagation tree is set for all the new mounts
+	'C1',..,'Cn' with exactly the same configuration as the propagation
+	tree of 'B'.  And finally the mount 'C' and 'A' are set to propagate to
+	each other.
+
+	7. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount. A new
+	mount 'C' which is clone of 'A', is created. Its root dentry is 'a' .
+	'C' is mounted on mount 'B' at dentry 'b'. Also new mounts 'C1', 'C2',
+	'C3' ... are created and mounted at the dentry 'b' on all mounts where
+	'B' propagates to. A new propagation tree is set for all the new mounts
+	'C1',..  'Cn' with exactly the same configuration as the propagation
+	tree of 'B'.  And finally the mount 'C' is made the slave of mount 'Z'.
+
+	8. 'A' is a unclonable mount and 'B' is a shared mount. This is a
+	invalid operation.
+
+	9. 'A' is a private mount and 'B' is a slave mount. A new mount 'C'
+	which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
+	mounted on mount 'B' at dentry 'b'.
+
+	10. 'A' is a shared mount and 'B' is a slave mount. A new mount 'C'
+	which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
+	mounted on mount 'B' at dentry 'b'.  And finally the mount 'C' and 'A'
+	set to  propagate to each other.
+
+	11. 'A' is a slave mount of mount 'Z' and 'B' is a slave mount. A new
+	mount 'C' which is clone of 'A' is created. Its root dentry is 'a'. 'C'
+	is mounted on mount 'B' at dentry 'b'.  And finally the mount 'C' is
+	made the slave of mount 'Z'.
+
+	12. 'A' is a unclonable mount and 'B' is a slave mount. This is a
+	invalid operation.
+
+	13. 'A' is a private mount and 'B' is a unclonable mount. A new mount
+	'C' which is clone of 'A', is created. Its root dentry is 'a' . 'C' is
+	mounted on mount 'B' at dentry 'b'.
+
+	14. 'A' is a shared mount and 'B' is a unclonable mount. A new mount
+	'C' which is a clone of 'A' is created. Its root dentry is 'a'. 'C' is
+	mounted on mount 'B' at dentry 'b'. Also 'C' is set for propagation
+	with 'A'.  In other words 'A' and 'C' are propagation peers of each
+	other.
+
+	15. 'A' is a slave mount of mount 'Z' and 'B' is a unclonable mount. A
+	new mount 'C' which is a clone of 'A' is created. Its root dentry is
+	'a'. This mount is mounted on mount 'B' at dentry 'b'. Also 'C' is set
+	as a slave mount of 'Z'.
+
+	16. 'A' is a unclonable mount and 'B' is a unclonable mount. This is a
+	invalid operation.
+
+
+5B) Rbind semantics
+	rbind is same as bind. Bind replicates the specified mount.  Rbind
+	replicates all the mounts in the tree belonging to the specified mount.
+	Rbind mount is bind mount applied to all the mounts in the tree.
+
+	If the source tree that is rbind has some unclonable mounts,
+	then the subtree under the unclonable mount is pruned in the new
+	location.
+
+	eg: lets say we have the following mount tree.
+
+		A
+	      /   \
+	      B   C
+	     / \ / \
+	     D E F G
+
+	     Lets say all the mount except C mount in the tree are something
+	     other than unclonable.
+
+	     If this tree is rbound to say Z
+
+	     We will have the following tree at the new location.
+
+		Z
+		|
+		A'
+	       /
+	      B'		Note: how the tree under C is pruned
+	     / \ 		in the new location.
+	    D' E'
+
+
+
+5C) Move semantics
+
+	Consider the following command
+
+	mount --move A  B/b
+
+	where 'A' is the source mount, 'B' is the destination mount and 'b' is
+	the dentry in the destination mount.
+
+	The outcome depends on the type of the mount of 'A' and 'B'. The table
+	below is a quick reference.
+     --------------------------------------------------------------------
+     |                          MOVE MOUNT OPERATION                    |
+     |******************************************************************|
+     |dest(B)-->|  shared       |       private  |  slave   |unclonable |
+     | source(A)|               |                |          |           |
+     |   |      |               |                |          |           |
+     |   v      |               |                |          |           |
+     |******************************************************************|
+     |          |               |                |          |           |
+     |  shared  | shared        |     shared     |shared    | shared    |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     | private  | shared        |      private   | private  | private   |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     | slave    | shared        |      slave     | slave    | slave     |
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+     |unclonable|  invalid      |     unclonable |unclonable| unclonable|
+     |          |               |                |          |           |
+     |          |               |                |          |           |
+      *******************************************************************
+	NOTE: moving a mount residing under a shared mount is invalid.
+
+      Details follow:
+
+	1. 'A' is a private mount and 'B' is a private mount. The mount 'A' is
+	mounted on mount 'B' at dentry 'b'.
+
+	2. 'A' is a shared mount and 'B' is a private mount.  The mount 'A' is
+	mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to be a shared
+	mount.
+
+	3. 'A' is a slave mount of mount 'Z' and 'B' is a private mount.  The
+	mount 'A' is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues
+	to be a slave mount of mount 'Z'.
+
+	4. 'A' is a unclonable mount and 'B' is a private mount. The mount 'A'
+	is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
+	unclonable mount.
+
+	5. 'A' is a private mount and 'B' is a shared mount. The mount 'A' is
+	mounted on mount 'B' at dentry 'b'. Also new mount 'A1', 'A2'... 'An'
+	are created and mounted at dentry 'b' on all mounts that receive
+	propagation from mount 'B'. The mount 'A' becomes a shared mount and a
+	propagation tree is created in the exact same configuration as that of
+	'B'. This new propagation tree contains all the new mounts 'A1',
+	'A2'...  'An'.
+
+	6. 'A' is a shared mount and 'B' is a shared mount.  The mount 'A' is
+	mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1', 'A2'...'An'
+	are created and mounted at dentry 'b' on all mounts that receive
+	propagation from mount 'B'. A new propagation tree is created in the
+	exact same configuration as that of 'B'. This new propagation tree
+	contains all the new mounts 'A1', 'A2'...  'An'.  And this new
+	propagation tree is appended to the already existing propagation tree
+	of 'A'.
+
+	7. 'A' is a slave mount of mount 'Z' and 'B' is a shared mount.  The
+	mount 'A' is mounted on mount 'B' at dentry 'b'.  Also new mounts 'A1',
+	'A2'... 'An' are created and mounted at dentry 'b' on all mounts that
+	receive propagation from mount 'B'. A new propagation tree is created
+	in the exact same configuration as that of 'B'. This new propagation
+	tree contains all the new mounts 'A1', 'A2'...  'An'.  And this new
+	propagation tree is appended to the already existing propagation tree of
+	'A'.  Mount 'A' continues to be the slave mount of 'Z'.
+
+	8. 'A' is a unclonable mount and 'B' is a shared mount. The operation
+	is invalid. Because mounting anything on the shared mount 'B' can
+	create new mounts that get mounted on the mounts that receive
+	propagation from 'B'.  And since the mount 'A' is unclonable, cloning
+	it to mount at other mountpoints is not possible.
+
+	9. 'A' is a private mount and 'B' is a slave mount. The mount 'A' is
+	mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a private
+	mount.
+
+	10. 'A' is a shared mount and 'B' is a slave mount.  The mount 'A' is
+	mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to be a shared
+	mount.
+
+	11. 'A' is a slave mount of mount 'Z' and 'B' is slave mount.  The
+	mount A is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to
+	be a slave mount of mount Z.
+
+	12. 'A' is a unclonable mount and 'B' is a slave mount. The mount 'A'
+	is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
+	unclonable mount.
+
+	13. 'A' is a private mount and 'B' is a unclonable mount. The mount 'A'
+	is mounted on mount 'B' at dentry 'b'. mount 'A' continues to be a
+	private mount.
+
+	14. 'A' is a shared mount and 'B' is a unclonable mount.  The mount 'A'
+	is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues to be a
+	shared mount.
+
+	15. 'A' is a slave mount of mount 'Z' and 'B' is unclonable mount.  The
+	mount 'A' is mounted on mount 'B' at dentry 'b'.  Mount 'A' continues
+	to be a slave mount of mount Z.
+
+	16. 'A' is a unclonable mount and 'B' is a unclonable mount. The mount
+	'A' is mounted on mount 'B' at dentry 'b'. Mount 'A' continues to be a
+	unclonable mount.
+
+5D) Mount semantics
+
+	Consider the following command
+
+	mount device  B/b
+
+	'B' is the destination mount and 'b' is the dentry in the destination
+	mount.
+
+	The above operation is the same as bind operation with the exception
+	that the source mount is always a private mount.
+
+
+5E) Unmount semantics
+
+	Consider the following command
+
+	umount A
+
+	where 'A' is a mount mounted on mount 'B' at dentry 'b'.
+
+	If mount 'B' is shared, then all most-recently-mounted mounts at dentry
+	'b' on mounts that receive propagation from mount 'B' and does not have
+	sub-mounts within them are unmounted.
+
+	Example: Lets say 'B1', 'B2', 'B3' are shared mounts that propagate to
+	each other.
+
+	lets say 'A1', 'A2', 'A3' are first mounted at dentry 'b' on mount
+	'B1', 'B2' and 'B3' respectively.
+
+	lets say 'C1', 'C2', 'C3' are next mounted at the same dentry 'b' on
+	mount 'B1', 'B2' and 'B3' respectively.
+
+	if 'C1' is unmounted, all the mounts that are most-recently-mounted on
+	'B1' and on the mounts that 'B1' propagates-to are unmounted.
+
+	'B1' propagates to 'B2' and 'B3'. And the most recently mounted mount
+	on 'B2' at dentry 'b' is 'C2', and that of mount 'B3' is 'C3'.
+
+	So all 'C1', 'C2' and 'C3' should be unmounted.
+
+	If any of 'C2' or 'C3' has some child mounts, then that mount is not
+	unmounted, but all other mounts are unmounted. However if C1 is told to
+	be unmounted and C1 has some sub-mounts, the umount operation is failed
+	entirely.
+
+5F) Clone Namespace
+
+	A cloned namespace has all the mounts as that of the parent namespace,
+	except that it skips all the mounts under a unclonable mount.
+
+	Lets say 'A' and 'B' are the corresponding mounts in the parent and the
+	child namespace.
+
+	If 'A' is shared, then 'B' is also shared and 'A' and 'B' propagate to
+	each other.
+
+	If 'A' is a slave mount of 'Z', then 'B' is also the slave mount of
+	'Z'.
+
+	If 'A' is a private mount, then 'B' is a private mount too.
+
+	If 'A' is unclonable mount, 'B' does not exist.
+
+6F) Misc Semantics
+
+	A given mount can be in one of the states
+	1) shared
+	2) slave
+	3) shared and slave
+	4) private
+	5) unclonable
+
+	Note the state 'shared and slave'. This state indicates that the mount
+	is a slave of some master mount, and it is shared too.  This mount
+	receives propogation events from the master mount, and also forwards
+	propagation events to its shared peers and its slave mounts.
+
+	Only a shared mount can be made a slave by executing the following
+	command
+		mount --make-slave mount
+	A shared mount that is made as a slave will not be shared anymore.
+
+	Only a slave mount can be made as 'shared and slave' by executing
+	the following command
+		mount --make-shared mount
+
+6) Quiz
+
+	A. What happens when the following set of commands are executed?
+
+	mount --bind /mnt /mnt
+	mount --make-shared /mnt
+	mount --bind /mnt /tmp
+	mount --move /tmp /mnt/1
+
+	what should be the contents of /mnt /mnt/1 /mnt/1/1 should be?
+	Should they all be identical? or should /mnt and /mnt/1 be
+	identical only?
+
+	B. What happens when the following set of commands are executed?
+
+	mount --make-rshared /
+	mkdir -p /v/1
+	mount --rbind / /v/1
+
+	what should be the content of /v/1/v/1 be?
+
+
+	C. What happens when the following set of commands are executed
+		mount --bind /mnt /mnt
+		mount --make-shared /mnt
+		mkdir -p /mnt/1/2/3 /mnt/1/test
+		mount --bind /mnt/1 /tmp
+		mount --make-slave /mnt
+		mount --make-shared /mnt
+		mount --bind /mnt/1/2 /tmp1
+		mount --make-slave /mnt
+
+		At this point we have the first mount at /tmp and
+		its root dentry is 1. Lets call this mount 'A'
+		And then we have a second mount at /tmp1 with root
+		dentry 2. Lets call this mount 'B'
+		Next we have a third mount at /mnt with root dentry
+		mnt. Lets call this mount 'C'
+
+		'B' is the slave of 'A' and 'C' is a slave of 'B'
+		A -> B -> C
+
+		at this point if we execute the following command
+
+		mount --bind /bin /tmp/test
+
+		The mount is attempted on 'A'
+
+		will the mount propagate to 'B' and 'C' ?
+
+		what would be the contents of
+		/mnt/1/test be?
+
+
+	D. What happens when the following set of commands are executed?
+
+	mount --bind /mnt /mnt
+	mount --make-shared /mnt
+	mkdir -p /mnt/1 /mnt/2
+	mount --bind /usr  /mnt/1
+	mount --bind /mnt  /mnt/2
+
+		a) mount --bind /var /mnt/2
+		   what should be the contents of /mnt/1 and /mnt/2 be?
+
+		b) mount --bind /var /mnt/1
+		   what should the contents of /mnt/1 and /mnt/2 be?
+
+7) FAQ
+
+	Q1. Why is bind mount needed? How is it different from symbolic links?
+	symbolic links can get stale if the destination mount gets unmounted
+	or moved. Bind mounts continue to exist even if the other mount is
+	unmounted or moved.
+
+	Q2. Why can't the shared subtree be implemented using exportfs?
+	exportfs is a heavyweight way of accomplishing part of what shared
+	subtree can do. I cannot imagine a way to implement the semantics of
+	slave mount using exportfs?
+
+	Q3 Why is unclonable mount needed?
+	if one rbind mounts a tree within the same subtree 'n' times
+	the number of mounts created is a exponential function of 'n'.
+	Having unclonable mount can help prune the unneeded bind mounts.
+
+8) Bugs
+
+	Current VFS implementation makes the most-recent-mount visible
+	instead of making the top-most mount visible.
+
+	This edge-case shows up when multiple mounts are mounted on
+	the same dentry of a given mount.
+
+	consider the following command sequence
+
+	(1) cd /mnt
+	(2) mount --bind /usr /mnt
+	(3) mount --bind /bin /mnt
+	(4) mount --bind /var .
+
+	after step 1, the pwd of the process points to the 'mnt' dentry
+	of the root mount.  lets call the root mount as 'A'
+
+	after step 2, a new mount is laid on top of 'A' at the mountpoint
+	'mnt'.  lets call this mount 'B'
+
+	after step 3, a new mount is laid on top of 'B' on the root dentry of
+	'B'.  lets call this new overlaid mount as 'C'. At this point the
+	visible content of /mnt is the content of 'C'.
+
+	however at step 4, a new mount is laid on top of 'A' at the same
+	mountpoint 'mnt' as that of 'B'. Lets call the new mount 'D'.
+
+	Note mount 'B' resides on top of 'A', and mount 'C' is mounted on top
+	of 'A' at the same mountpoint as that of 'B'.
+
+	Since 'B' is above 'A' and 'C' is below 'B' but above 'A', one would
+	naturally expect 'B' to continue to be visible.
+
+	But that is not the case. 'C' becomes visible as per the current
+	implementation of VFS.
+
+	This semantics if extended to shared subtree can cause mind boggling
+	confusion.
+
+	Here is a scenario with shared subtree. Sorry it is complex.
+
+	mount --bind /mnt /mnt
+	mount --make-shared /mnt
+	mkdir -p /mnt/1 /mnt/2
+	mount --bind /usr  /mnt/1
+	mount --bind /mnt  /mnt/2
+
+	At this stage the mount at /mnt/2 and /mnt belong to the same pnode
+	which means mounts under them propagate to each other.
+
+	mount --bind /var /mnt/1
+
+	the contents of /var will be visible under /mnt/1 and not under /mnt/2
+	Instead if 'mount --bind /var /mnt/2' is executed, the contents of /var
+	is visible under /mnt/1 as well as /mnt/2 .
+
+	On analysis it turns out the culprit is the current rule which says
+	'expose the most-recent-mount and not the topmost mount'
+
+	The current implementation of shared subtree has not changed the
+	semantics for the normal case. But has implemented the
+	top-most-mount-visible semantics for mounts that happen in the context
+	of shared-subtree. This could be perceived as a bug!  This issue needs
+	some collective thought.
+
+
+9) Implementation
+
+	4 new fields are added to struct vfsmount
+	->mnt_share
+	->mnt_slave_list
+	->mnt_slave
+	->mnt_master
+
+	->mnt_share links together all the mount to/from which this mount
+	send/receives mount/umount propagations.
+
+	->mnt_slave_list links all the mounts to which this mount propagates to.
+
+	->mnt_slave links together all the slaves that its master mount
+	propagates to.
+
+	->mnt_master points to the master mount from which this mount receives
+	propagation.
+
+
+	->mnt_flags takes two more flags to indicate the propagation status of
+	the mount.  MNT_SHARE indicates that the mount is a shared mount.
+	MNT_UNCLONABLE indicates that the mount cannot be replicated.
+
+
+	A example propagation tree looks as shown in the figure below.
+	[ NOTE: Though it looks like a forest, if we consider all the shared
+	mounts as a conceptual entity called 'pnode', it becomes a tree]
+
+
+		        A <--> B <--> C <---> D
+		       /|\	      /|      |\
+		      / F G	     J K      H I
+		     /
+		    E<-->K
+			/|\
+		       M L N
+
+	In the above figure  A,B,C and D all are shared and propagate to each
+	other.   'A' has got 3 slave mounts 'E' 'F' and 'G' 'C' has got 2 slave
+	mounts 'J' and 'K'  and  'D' has got two slave mounts 'H' and 'I'.
+	'E' is also shared with 'K' and they propagate to each other.  And
+	'K' has 3 slaves 'M', 'L' and 'N'
+
+	A's ->mnt_share links with the ->mnt_share of 'B' 'C' and 'D'
+
+	A's ->mnt_slave_list links with ->mnt_slave of 'E', 'F' and 'G'
+
+	E's ->mnt_share links with ->mnt_share of K
+	'E', 'F', 'G' have their ->mnt_master point to struct vfsmount of 'A'
+	'M', 'L', 'N' have their ->mnt_master point to struct vfsmount of 'K'
+	K's ->mnt_slave_list links with ->mnt_slave of 'M', 'L' and 'N'
+
+	C's ->mnt_slave_list links with ->mnt_slave of 'J' and 'K'
+	J and K's ->mnt_master points to struct vfsmount of C
+	and finally D's ->mnt_slave_list links with ->mnt_slave of 'H' and 'I'
+	'H' and 'I' have their ->mnt_master pointing to struct vfsmount of 'D'.
+
+
+	The propagation tree is orthogonal to the mount tree.
+	One of the most complex operation is
+	mount --move A  B
+
+	where 'A' contains a mount tree.
+	'A' has its own propagation tree and 'B' has its own propagation tree.
+
+	The overall algorithm breaks the operation into 3 phases:
+	(look at attach_recursive_mnt() and propagate_prepare_mount())
+
+	1. prepare phase.
+	2. commit phases.
+	3. abort phases.
+
+	Prepare phase:
+
+		for each mount in the source tree:
+	1. unlink the mount from its ->mnt_list
+	2. a) attach that mount to the destination
+	   b) create the necessary number of clone mounts that propagate to
+	      all the mounts that the destination mount propagates to.
+	   c) do not attach the mount to destination, however note down
+	   	in its ->mnt_parent and ->mnt_mountpoint location
+		by holding a reference to them.
+	   c) link all the new mounts to form a propagation tree that is
+	   	identical to the propagation tree of the destination mount.
+	   d) link all these new mounts together through ->mnt_list
+
+	   If this phase is successful, there should be 'n' new propagation
+	   trees; where 'n' is the number of mounts in the source tree.
+	   Go to the commit phase
+
+	   if any memory allocation fails, or any thing else fails, go to the
+	   abort phase.
+
+	Commit phase
+		for each mount in the source tree (say A)
+	   	walk that mounts mnt_list and for each mount  (say B)
+	   	a) delink its ->mnt_list
+	   	a) attach the mount to its parent. (->mnt_child and ->mnt_hash
+							gets linked)
+		b) add the mount to the parent's namespace
+		c) mark the mount as MNT_SHARE if the parent mount is MNT_SHARE
+		d) add the ->mnt_expire to the list of that of 'A'
+
+	Abort phase
+		for each mount in the source tree (say A)
+		walk that mount's mnt_list and for each mount
+		a) delink it from its propagation tree
+		b) delete the mount if was newly cloned.
+		e) release any references it held to its parent mount and
+			the mountpoint.
+
+
+
+	mount --rbind A  B
+
+	is similar to --move operation. Here the source tree is not exactly
+	that of 'A', but a clone of the tree at A.  Hence the additional
+	operation is to link the propagation tree created in the prepare
+	phase to that of 'A's propagation tree.
+
+	All other operations are trivial and should be clear by looking at the
+	code.
+
+	NOTE: all the propagation related functionality resides in the file
+	pnode.c
+
+------------------------------------------------------------------------
+
+version 0.1  (created the initial document, Ram Pai linuxram@us.ibm.com)
