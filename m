Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVEXMBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVEXMBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEXMBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:01:47 -0400
Received: from pat.uio.no ([129.240.130.16]:47799 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262006AbVEXMBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:01:40 -0400
Subject: Re: NFS corruption on 2.6.11.7
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenneth Johansson <ken@kenjo.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116929711.6237.8.camel@tiger>
References: <1116888428.5206.14.camel@tiger>
	 <1116894917.11483.111.camel@lade.trondhjem.org>
	 <1116929711.6237.8.camel@tiger>
Content-Type: text/plain
Date: Tue, 24 May 2005 08:01:28 -0400
Message-Id: <1116936088.10707.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.543, required 12,
	autolearn=disabled, AWL 1.41, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 24.05.2005 Klokka 12:15 (+0200) skreiv Kenneth Johansson:

> > > :/export/home/ken /home/ken nfs rw,v3,rsize=32768,wsize=32768,hard,udp,lock,addr=amd 0 0
> > > 
> > 
> > I'm seeing no problems at all with this on a loopback mount with
> > 2.6.12-rc4. Mind giving us some more details on your setup?
> > 
> > Cheers,
> >   Trond

Does the above export line mean that you are running with amd? If so,
could you retry using an ordinary NFS mount (preferably a loopback mount
- i.e. mount something over "localhost").

Again, please could you give us more details on how you are doing these
tests: what hardware (i.e. what NIC, switch, server, memory,...), lsmod
output, (and ditto for the server).
How are you using your scripts? Are you first running one on the server,
then the other on the client, are you deleting the old files before you
start a new run, etc.


> I did some more investigation what type of data error I get and it looks
> a bit strange. I always get 28 bytes wrong in a sequence some times this
> is data repeated from previous in the file but not always.  Anybody know
> what cache line size this cpu has?
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Athlon(TM) XP 2200+
> stepping        : 0
> cpu MHz         : 1802.998
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
> bogomips        : 3547.13
> 
> Here is a sample if three files with errors in them.
> 
> file 13 "od -Ax -tx1z"
> 
> 
> -924dc0 df b3 0c 89 2d a2 83 da 1c 08 f2 66 da f6 6b f4  >....-......f..k.<
> +924dc0 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=..<
> 
> -924dd0 af c2 44 57 9a 13 01 43 84 bf 99 c3 1b 16 8a 00  >..DW...C........<
> +924dd0 3e 64 d7 bd 4f 8d 26 cf 4f 4f 2c 62 1b 16 8a 00  >>d..O.&.OO,b....<
> 
> 
> 28 bytes wrong in a sequence
> The data is a repeat from previous data in the file.
> 
> >grep "43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd" 13_org 
> 924d40 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=..<
> 
> >grep "43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd" 13_err 
> 924d40 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=..<
> 924dc0 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=..<
> 
> 924dc0 is a copy of 924d40
> 128 bytes offset
> 
> 
> file 14 "od -Ax -tx1z"
> 
> -0912f0 91 45 bb cd eb 4f 01 d3 69 27 88 b5 7d 7d 17 8d  >.E...O..i'..}}..<
> +0912f0 b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29  >.?N]....Qy..>S.)<
> 
> -091300 7d 94 8e f9 81 d0 c2 4a b5 8e c6 af b0 03 4c 16  >}......J......L.<
> +091300 d9 05 ac 0d fc eb 00 71 17 bd fb 3e b0 03 4c 16  >.......q...>..L.<
> 
> >grep "b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29" 14_err
> 0912b0 b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29  >.?N]....Qy..>S.)<
> 0912f0 b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29  >.?N]....Qy..>S.)<
> 
> 28 bytes wrong
> 64 bytes offset
> 
> 
> file 16 "od -Ax -tx1z"
> 
> -635200 c3 1d f2 b8 c4 d5 12 c1 3f 48 e6 9d dc 98 1f e5  >........?H......<
> +635200 c3 1d f2 b8 c4 d5 12 c1 00 10 00 00 00 d0 ec 08  >................<
> 
> -635210 9e 54 e7 f1 49 5b 1e d0 9f e2 7c 26 24 cb 98 24  >.T..I[....|&$..$<
> +635210 00 10 00 00 00 90 14 08 00 10 00 00 00 50 25 06  >.............P%.<
> 
> -635220 25 fc 63 2a bf 07 b4 c0 cf a1 67 9b ef 01 5d 6d  >%.c*......g...]m<
> +635220 00 10 00 00 bf 07 b4 c0 cf a1 67 9b ef 01 5d 6d  >..........g...]m<
> 
> 28 bytes wrong 
> This time the data is not from this file.
> 
> 
> 
> 

