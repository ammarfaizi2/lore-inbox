Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRETWtk>; Sun, 20 May 2001 18:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbRETWtT>; Sun, 20 May 2001 18:49:19 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:9744 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262262AbRETWtR>; Sun, 20 May 2001 18:49:17 -0400
Date: Mon, 21 May 2001 00:49:18 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Hudec <bulb@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: question: permission checking for network filesystem
In-Reply-To: <20010520172948.A27935@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1010521001448.31037A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I'm trying to impelemnt a lightweight network filesystem and ran into
> trouble implementing lookup, permissions and open.
> 
> The protocol requires me to specify open mode in it's open command. The
> open mode has 4 bits: read, write, append and execute. But I can't tell
> execution from read in file_operations->open. I could send the open command
> from the inode_operations->permission, but this does not solve the problem,
> as I can't find weather to count the new file descriptor as reader or
> executer (I have to know that when closing the file).

The idea of opening files for read and opening files for execution is
bogus and you should fix the protocol, not add more crap to your
implementation.

There are two ways how you can implement security in network file system:

1. you expect that users have not root access on the client machine and
you check permissions on client (like in NFS). In this case the 'x' and
'r' bits are checked on the client and you don't have to care about them
in protocol. 

2. you expect that users have root access on client machine and you check
permissions on the server. In this case users can read executed files
anyway.

> The server always checks permission on the actual request, so I can't open
> the file for reading, when it should be open for execution.

It seems that you are implementing case 2 of the above.

If you are checking permissions on server, read/execute have no security
meaning. Client can send 'execute' request and then store data somwhere to
file. Opening for 'execute' won't enhance your security.

> Could anyone see a solution other than adding a flags to open mode (say
> O_EXEC and O_EXEC_LIB), that would be added to the dentry_open in open_exec
> and sys_uselib? I don't like the idea of pathing vfs for this.

Send always 'open for read' and ignore 'open for execute'.



And also remember that having file without read permission and with
execute permission makes sence only for suid programs. User can read the
file via /proc/<pid>/mem or attach debugger to the process...

Mikulas

