Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSEQMX6>; Fri, 17 May 2002 08:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315255AbSEQMX5>; Fri, 17 May 2002 08:23:57 -0400
Received: from slip-202-135-75-243.ca.au.prserv.net ([202.135.75.243]:11657
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315170AbSEQMXs>; Fri, 17 May 2002 08:23:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: Your message of "Fri, 17 May 2002 02:35:06 MST."
             <20020517.023506.105129697.davem@redhat.com> 
Date: Fri, 17 May 2002 22:26:22 +1000
Message-Id: <E178gok-0001Ln-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020517.023506.105129697.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Fri, 17 May 2002 19:49:40 +1000
>    
>    Sorry I wasn't clear: I'm saying *replace*, not add,
> 
> I don't understand what you are proposing then.  There are some
> instances that do want to know how many bytes did make it before
> the -EFAULT event.

Yes.  There are 52 places which care.  Most of these are unneccessary
attempts to return eg. number of bytes written in read call before we
hit the fault, instead of -EFAULT.

The one case I found which obviously needed it was the mount options
code, and I proposed a simple (slow) gradually_copy_from_user for this
case:

	static inline unsigned long
	gradual_copy_from_user(void *to, const void *from, unsigned long n)
	{
		unsigned long i;

		for (i = 0; i < n; i++, to++, from++) {
			if (copy_from_user(from, to, 1) != 0)
				break;
		}
		return n - i;
	}

Here is the list of places in 2.5.15 which actually use the return
values other than zero:

./fs/proc/generic.c:108: 		n -= copy_to_user(buf, start < page ? page : start, n);
./fs/hfs/file.c:263:	i = copy_from_user(data, buf, count);
./fs/hfs/file.c:390:				chars -= copy_to_user(buf, p, chars);
./fs/hfs/file.c:472:			copy_from_user(p, buf, c);
./fs/hfs/file_cap.c:162:		memcount -= copy_to_user(buf, ((char *)&meta) + pos, memcount);
./fs/hfs/file_cap.c:234:		mem_count -= copy_from_user(((char *)&meta) + pos, buf, mem_count);
./fs/hfs/file_hdr.c:422:		left -= copy_to_user(buf, ((char *)&meta) + pos, left);
./fs/hfs/file_hdr.c:592:			left -= copy_to_user(buf, p + offset, left);
./fs/hfs/file_hdr.c:671:		left -= copy_from_user(((char *)&meta) + pos, buf, left);
./fs/hfs/file_hdr.c:703:		left -= copy_from_user(((char *)&meta) + pos, buf, left);
./fs/hfs/file_hdr.c:868:			left -= copy_from_user(p + offset, buf, left);
./fs/namespace.c:670:	i = size - copy_from_user((void *)page, data, size);
./mm/filemap.c:1189:	left = __copy_to_user(desc->buf, kaddr + offset, size);
./drivers/char/pty.c:158:			n -= copy_from_user(temp_buffer, buf, n);
./drivers/char/esp.c:1332:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/serial.c:1876:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/n_tty.c:922:		retval = copy_to_user(*b, &tty->read_buf[tty->read_tail], n);
./drivers/char/vc_screen.c:251:		ret = copy_to_user(buf, con_buf_start, orig_count);
./drivers/char/vc_screen.c:325:		ret = copy_from_user(con_buf, buf, this_round);
./drivers/char/rocket.c:1606:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/rocket.c:1643:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/random.c:1362:			i -= copy_to_user(buf, (__u8 const *)tmp, i);
./drivers/char/random.c:1589:		bytes -= copy_from_user(&buf, p, bytes);
./drivers/char/riscom8.c:1247:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/specialix.c:1626:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/serial_amba.c:888:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/dz.c:706:			c -= copy_from_user (tmp_buf, buf, c);
./drivers/char/mxser.c:931:			c -= copy_from_user(mxvar_tmp_buf, buf, c);
./drivers/char/generic_serial.c:237:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/serial167.c:1257:		    c -= copy_from_user(tmp_buf, buf, c);
./drivers/char/amiserial.c:958:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/sbus/char/zs.c:1112:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/sbus/char/sab82532.c:1127:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/sbus/char/su.c:1234:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/sbus/char/aurora.c:1627:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/video/fbmem.c:386:	    count -= copy_to_user(buf, base_addr+p, count);
./drivers/video/fbmem.c:422:	    count -= copy_from_user(base_addr+p, buf, count);
./drivers/macintosh/macserial.c:1551:			c -= copy_from_user(tmp_buf, buf, c);
./drivers/s390/char/con3215.c:596:				c -= copy_from_user(raw->buffer + raw->head,
./drivers/s390/char/tuball.c:329:				len2 -= copy_from_user(ob->bc_buf + ob->bc_wr,
./arch/i386/kernel/vm86.c:79:	tmp = copy_to_user(&current->thread.vm86_info->regs,regs, VM86_REGS_SIZE1);
./arch/i386/kernel/vm86.c:80:	tmp += copy_to_user(&current->thread.vm86_info->regs.VM86_REGS_PART2,
./arch/i386/kernel/vm86.c:147:	tmp  = copy_from_user(&info, v86, VM86_REGS_SIZE1);
./arch/i386/kernel/vm86.c:148:	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
./arch/i386/kernel/vm86.c:148:	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
./arch/i386/kernel/vm86.c:195:	tmp  = copy_from_user(&info, v86, VM86_REGS_SIZE1);
./arch/i386/kernel/vm86.c:196:	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
./arch/mips/baget/vacserial.c:1085:			c -= copy_from_user(tmp_buf, buf, c);
./arch/mips/au1000/common/serial.c:1212:			c -= copy_from_user(tmp_buf, buf, c);
./arch/ppc/4xx_io/serial_sicc.c:988:            c -= copy_from_user(tmp_buf, buf, c);
./arch/ia64/hp/sim/simserial.c:328:			c -= copy_from_user(tmp_buf, buf, c);
./arch/cris/drivers/serial.c:2355:			c -= copy_from_user(tmp_buf, buf, c);
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
