Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbREUNdT>; Mon, 21 May 2001 09:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbREUNc5>; Mon, 21 May 2001 09:32:57 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35082 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261434AbREUNcr>; Mon, 21 May 2001 09:32:47 -0400
Date: Mon, 21 May 2001 15:32:46 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: question: permission checking for network filesystem
Message-ID: <20010521153246.A9454@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010520172948.A27935@artax.karlin.mff.cuni.cz> <Pine.LNX.3.96.1010521001448.31037A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010521001448.31037A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Mon, May 21, 2001 at 12:49:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I'm trying to impelemnt a lightweight network filesystem and ran into
> > trouble implementing lookup, permissions and open.
> > 
> > The protocol requires me to specify open mode in it's open command. The
> > open mode has 4 bits: read, write, append and execute. But I can't tell
> 
> There are two ways how you can implement security in network file system:
> 
> 1. you expect that users have not root access on the client machine and
> you check permissions on client (like in NFS). In this case the 'x' and
> 'r' bits are checked on the client and you don't have to care about them
> in protocol. 
> 
> 2. you expect that users have root access on client machine and you check
> permissions on the server. In this case users can read executed files
> anyway.

Neither. If user has acces to the protocol, he certainly can do some things
more. But you definitely can't check permissions on client. The trouble is,
that this limits access policy on server to what the clients understand.
Checking on server on the other hand allows server to implement any access
policy (even using 3rd party software) without having clients to know the
details (sou they can be kept stupid and simple = fast and managable)

> If you are checking permissions on server, read/execute have no security
> meaning. Client can send 'execute' request and then store data somwhere to
> file. Opening for 'execute' won't enhance your security.

Agree, but it will improve behavior. Or speed, rather. Otherwise open would
take 3(!) roundtrips (instead of two - now lookup can't be get rid of) -
lookup, permission and open. The protocol can do all three in one request.
The problem is I can't tell the 3 calls from VFS belong together.

> > Could anyone see a solution other than adding a flags to open mode (say
> > O_EXEC and O_EXEC_LIB), that would be added to the dentry_open in open_exec
> > and sys_uselib? I don't like the idea of pathing vfs for this.
> 
> Send always 'open for read' and ignore 'open for execute'.

Won't work for many reasons. Correct error code is one (could be removed by
pre-checking permission), exclusivity of write versus execute is the other
(can't be workaround). Checking permissions with lookup might be possible,
but won't solve the exec/write exclusion and put more trust on the client,
than is desireable.

> And also remember that having file without read permission and with
> execute permission makes sence only for suid programs. User can read the
> file via /proc/<pid>/mem or attach debugger to the process...

It does not make sence (x without r). But it surely makes sence to have a
program with read but without exec permission (though it can be made to
run).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
