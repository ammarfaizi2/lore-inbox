Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSEUTDM>; Tue, 21 May 2002 15:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEUTDL>; Tue, 21 May 2002 15:03:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:40464 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S314546AbSEUTDL>;
	Tue, 21 May 2002 15:03:11 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205211902.g4LJ25562768@saturn.cs.uml.edu>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: hch@infradead.org (Christoph Hellwig)
Date: Tue, 21 May 2002 15:02:05 -0400 (EDT)
Cc: acme@conectiva.com.br (Arnaldo Carvalho de Melo),
        torvalds@transmeta.com (Linus Torvalds),
        vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
        zaitcev@redhat.com (Pete Zaitcev), linux-kernel@vger.kernel.org
In-Reply-To: <20020521093357.A6641@infradead.org> from "Christoph Hellwig" at May 21, 2002 09:33:57 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

------
> FreeBSD has:
> /* return 0 on success, EFAULT on failure */
> int copyin(const void *udaddr, void *kaddr, size_t len);
> int copyout(const void *kaddr, void *udaddr, size_t len);

return copyin(x,y,z);                /* want EFAULT */
return copyin(x,y,z) ? -1 : 0;       /* want -1 */
return copyin(x,y,z);                /* want non-zero */

FreeBSD behavior might be best, considering where we
are most likely to share drivers.

------
> System V and derivates have:
> /* return 0 on success, -1 on failure */
> int  copyin(const  void  *userbuf, void *driverbuf, size_t cn);
> int  copyout(const  void *driverbuf, void *userbuf, size_t cn);

System V behavior is the easiest to use:

return copyin(x,y,z) & EFAULT;       /* want EFAULT */
return copyin(x,y,z);                /* want -1 */
return copyin(x,y,z);                /* want non-zero */

------
> OSF/1 has:
> /* return 0 on success, some non-specified error on failure) */
> int copyin(caddr_t user_src, caddr_t kernel_dest, u_int bcount);
> int copyout(caddr_t kernel_src, caddr_t user_dest, u_int bcount);

return copyin(x,y,z) ? EFAULT : 0;   /* want EFAULT */
return copyin(x,y,z) ? -1 : 0;       /* want -1 */
return copyin(x,y,z);                /* want non-zero */

Yuck... but good if it makes the assembly any faster.

------
With -EFAULT on an error:

return -copyin(x,y,z);       /* want EFAULT */
return copyin(x,y,z)>>31;    /* want -1 (rely on gcc's sign awareness) */
return copyin(x,y,z);        /* want non-zero */

Well, I like it.
