Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbQJ0TuS>; Fri, 27 Oct 2000 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbQJ0TuJ>; Fri, 27 Oct 2000 15:50:09 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:26119 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129993AbQJ0Tt7>; Fri, 27 Oct 2000 15:49:59 -0400
Message-ID: <39F9DB88.E1F6A46C@timpanogas.org>
Date: Fri, 27 Oct 2000 13:46:16 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
In-Reply-To: <B24306C66FF@vcnet.vc.cvut.cz> <20001027105754.C5628@vger.timpanogas.org> <20001027111159.A5775@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr,

Here's the complete set of 3.x/4.x/5.x Namespace NCP calls with proper
return codes.  I'll run down the huge-data info and post a bit later.

1.

NCP  code      2222/5716

Generate Directory Base and Volume Number

Returns the directory base for the file or directory in the name space
associated with
"namespace"

Request Packet (20 to ? bytes)

index    bytes   type or value        description
0         6        structure          Request Packet Header
6         2        0x5716             NCP Function Code
8         1        Namespace          Namespace number (0-DOS, 2-NFS,
4-LONG, 1-MAC)
9         3        reserved           '000''s
12        1        Volume Number      The volume the file resides in.
13        4                           ComponentHandle    
17        1                           ComponentHandleFlag
18        1                           The number of components in
ComponentPath
19        1...?                       ComponentPath

Reply Packet (17 bytes)

index    bytes   type or value        description

0         8        structure          Server Response Header
8         4                           The directory base of the file or
directory in the 
                                      namespace associated with
Namespace
12        4                           The directory base of the file or
directory in the DOS Name Space (The FAT Chain head)
16        1                           Volume Number


Completion codes

0x00      OK

2.

NCP     code     2222/5717

Query Name Space Information Format

Attempts to return the format of the information for the specified name
space on the volume associated with VolumeNumber.

Request Packet (10 bytes)

index     bytes    type or value      description

0          6        structure          Request Packet Header
6          2        0x5717             NCP Function Code
8          1                           Namespace
9          1                           Volume Number


Reply Packet (154 bytes)

index     bytes    type or value      description

0          8        structure          ServerResponseHeader
8          4                           fixed bit mask
12         4                           variable bit mask
16         4                           huge bit mask
20         2                           fixed bits defined
22         2                           variable bits defined
24         2                           huge bits defined
26         128                         fields length table  (for NFS,
this is the NFS structure in NWDIR.H in NWFS)

Completion codes

0x00       OK


3.

NCP     code     2222/5719

Set Name Space Information

Attempts to set iformation specific to the name space for the specified
entity.

Request Packet (531 bytes)

index     bytes    type or value     description

0          6        structure        RequestPacketHeader
6          2        0x5719           NCPFunctionCode
8          1                         Source Name Space
9          1                         Destination Name Space
10         1                         Volume Number
11         4                         DirEntry
15         4                         NSInfoBitMask
19         512                       NSSpecificInfo  (the modified
namespace records)

Reply Packet (8 bytes)

index      bytes    type or value    description

0          8        structure        ServerResponseHeader

Completion Codes

0x00       OK


4.   

NCP     code    222/571B

Set Huge Name Space Information

Attempts to set the huge Namespace information for the entity associated
with DirEntry

Request Packet (39 bytes)

index      bytes     type of value     description

0           6         structure         RequestPacketHeader
6           2         0x571B            NCPFunctionCode
8           1                           Namespace
9           1                           Volume Number
10          4                           DirEntry
14          4                           HugeMask
18         16                           HugeStateInfo
34          4                           HugeDataLength
38          1                           HugeData

Reply Packet (28 bytes)

index     bytes      type or value     description

0           8         structure         ServerResponseHeader
8          16                           HugeStateInfo
24          4                           Total Amount of Huge Data Used

Completion Code

0x00      OK


I have the formats for the other NameSpace NCPs, but it looks like your
code is handling these.  If you need them,
let me know.  I have a 600 page document I wrote two years ago that
details every single NCP and NDS NCP used,
and can send it to you via UPS in .cz.   It's too big to fax, or post.


The format of the namespace records is the same as in NWDIR.H in NWFS --
NetWare just passes them through to the client
so all the field layouts are there.  Unless the NFS server is loaded on
NetWare, you can just about write anythin you
want into the NFS namespace, since NetWare does not check the namespace
records (other than the first seven common fields
that are the same for all namespace records).  If NFSSERV.NLM loads on
the server, he does do a consistency check and 
will vrepair the volume if any of the fields are hosed.

Other NCPs you may need (let me know if you need these as well) -- looks
like you are already implementing these correctly.

2222/5714       Get Name Space Information
2222/5715       Search for a File or Subdirectory
2222/5715       Get Path String from Short Dir Handle

2222/5718       Get Name Spaces Loaded List from Volume Number
2222/571C       Get Full Path String
2222/571D       Get Effective Directory Rights

2222/6801       Ping for NDS NCP
2222/6802       Send NDS FRagment/Reply
2222/6803       Close NDS Fragment
2222/6804       Return Bindery Context (you need to implement this one
-- I did not see it in your code)
2222/6805       Monitor NDS Connection (this one will allow you to
intercept NDS replica packets and suck an NDS replica local)

2222/162F       Get Name Space Information
2222/1630       Get Name Space Directory Entry
2222/1631       Open Data Stream (this NCP will allow you to open the
MAC namespace data fork and read it remotely for MAC clients)

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
