Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbRAFTXR>; Sat, 6 Jan 2001 14:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbRAFTXD>; Sat, 6 Jan 2001 14:23:03 -0500
Received: from latt.if.usp.br ([143.107.129.103]:6660 "HELO latt.if.usp.br")
	by vger.kernel.org with SMTP id <S132798AbRAFTWx>;
	Sat, 6 Jan 2001 14:22:53 -0500
Date: Sat, 6 Jan 2001 17:22:50 -0200 (BRST)
From: "Jorge L. deLyra" <delyra@latt.if.usp.br>
Reply-To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
cc: Andi Kleen <ak@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>,
        Antonio Fernando Correa de Moraes <afmoraes@uol.com.br>,
        assirati@socrates.if.usp.br
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: <Pine.LNX.3.96.1010103114120.21947A-100000@latt.if.usp.br>
Message-ID: <Pine.LNX.3.96.1010106163722.752A-100000@latt.if.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From cks@utcc.utoronto.ca Sat Jan  6 16:36:57 2001
> Date: Sat, 6 Jan 2001 00:52:21 -0500
> From: Chris Siebenmann <cks@utcc.utoronto.ca>
> To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
> Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
> 
> You write:
> [about re-exporting NFS mounts via NFS:]
> | Well, I hope some solution is found, since this is an important feature.
> | It would be nicer in knfsd, I think, but if that proves unpractical for
> | some reason, your packet filter/forwarder might just be the answer.
> 
>  This is essentially impossible to do reliably; one way or another you
> have to make tradeoffs. The basic problem is that of NFS filehandles.
> NFS filehandles are fixed-size persisent opaque objects that uniquely
> identify a given file to the server. Now, imagine that you are
> attempting to re-export NFS partitions (from multiple systems) as well
> as export some of your own local partitions. How do you come up with the
> NFS filehandles that you're going to give clients, in general, and keep
> the result persistent?
> 
>  You have to somehow add information (what server/filesystem the object
> is on/for) to an existing, opaque block of information of the same size,
> all of which may be significant, and that you can't make any assumptions
> about the format of. There's no place for the information to go, unless
> you create a potentially unboundedly large mapping table and store it
> locally, or unless your code is only really going to work with known
> sources of filehandles so you know how they're put together and thus
> where you can stuff some extra information in.
> 
> (unfsd's NFS filehandles are derived from file name and file location,
> if I remember correctly, and can erroneously become invalid if the file
> is moved around in the wrong way. That's the other way out, but it is
> not 100% reliable, and if what someone wants to do with the server hits
> this case hard you are truly out of luck.)

OK, I think I got your point, we seem to be dealing with a limitation of
the NFS protocol. However, Andi Kleen has this idea of a packet filtering
and relay daemon. Since the packets of the private network cannot appear
on the Internet, I guess there would have to be some kind of tunneling
involved. Well, trying to elaborate on that, couldn't you solve the
file-handling problem by building a local cache on disk in the front-end?
That would reduce the re-exportation problem to the problem of exporting a
local ext2 filesystem. I imagine something like this: let's say that

	latt.int is one home server on the Internet
	dfma.int is another home server on the Internet
	pmcs.int is the front-end, which is on both networks
	pmcs.prv is the name of the front end in the private network
	node.prv is any compute node in the private network

latt.int:/home <---> mounted as /latt/home on pmcs.int
dfma.int:/home <---> mounted as /dfma/home on pmcs.int
                                     ^
                                     |
   re-export daemon: files requested | get cached into
                                     |
                                     V
                                   /rexp on pmcs
                (say, with paths /rexp/latt/home/..., etc)
                                     ^
                                     |
                      pmcs.prv:/rexp +---> mounted as /rexp on node.prv

The re-export daemon on pmcs would have to keep in /rexp the files which
are required via the mount of /rexp by the nodes, copying them from the
appropriate Internet mount, and copying back into these mounts new files
which show up in /rexp/. Would something like this be feasible?

							Cheers,

----------------------------------------------------------------
        Jorge L. deLyra,  Associate Professor of Physics
            The University of Sao Paulo,  IFUSP-DFMA
       For more information: finger delyra@latt.if.usp.br
----------------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
