Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266017AbRGIItz>; Mon, 9 Jul 2001 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGIItq>; Mon, 9 Jul 2001 04:49:46 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:49544 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S266017AbRGIItg>;
	Mon, 9 Jul 2001 04:49:36 -0400
Date: Mon, 9 Jul 2001 10:50:44 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: msync() bug
Message-ID: <20010709105044.A29658@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 10:45am  up 10 days, 22:37,  9 users,  load average: 0.16, 0.06, 0.01
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I was preparing some lecture last night and stumbled onto this bug. Maybe
some of you can shed some light on it.

Basically, I just memory map /dev/mem at 0xb8000 (text mode - yes I know you
shouldn't do this, but it was to illustrate something), reads 4k, changes it
writes it back.

Now everything works fine unless I do an msync() in which case I get an oop=
s:

------------< snip <------< snip <------< snip <------------
root@oasis:~/tuesday-clug-talk/text-mode# ./text-mode
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
 c011e752
 *pde =3D 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[<c011e752>]
 EFLAGS: 00010246
 eax: c10030f0   ebx: c10030f0   ecx: 00000000   edx: c10030f0
 esi: 00017000   edi: cc75d404   ebp: cc7cf05c   esp: cc75ff38
 ds: 0018   es: 0018   ss: 0018
 Process text-mode (pid: 516, stackpage=3Dcc75f000)
 Stack: 00417000 c0120515 c10030f0 00000004 ccddf1a0 40018000 00000000 4001=
7000
        cc75d404 40417000 cc75e000 00018000 40000000 00018000 40000000 0000=
0000
	    40018000 c0120627 cceed420 40017000 00001000 00000004 cceed420 40017000
Call Trace: [<c0120515>] [<c0120627>] [<c012072d>] [<c0106d6b>]

Code: 8b 51 08 89 42 04 89 10 8d 51 08 89 50 04 89 41 08 8b 41 20
Segmentation fault
root@oasis:~/tuesday-clug-talk/text-mode#
root@oasis:~# cat /proc/ksyms | grep c011f
c011f000 ___wait_on_page_Rf9de9e1d
c011fb74 generic_file_read_Reaf528e4
c011f614 do_generic_file_read_Rc634b32a
c011f1d8 __find_lock_page_R31595861
c011ff68 filemap_nopage_R50c6d0e7
c011f154 lock_page_R7c236ed9
root@oasis:~# cat /proc/ksyms | grep c0120
c012057c generic_file_mmap_Rf655e8fd
c0120368 filemap_sync_R86ba6830
root@oasis:~# cat /proc/ksyms | grep c0106
root@oasis:~# cat /proc/ksyms | grep c0105
c01051bc machine_real_restart_R3da1b07a
c01055ac dump_thread_Rae90b20c
c01053fc kernel_thread_R7e9ebb05
c0105a60 __down_failed
c0105a6c __down_failed_interruptible
c0105a78 __down_failed_trylock
c0105a84 __up_wakeup
c0105aac __down_write_failed
c0105a90 __down_read_failed
c0105cd0 __rwsem_wake
c0105840 get_wchan_R280eab06
c0105110 disable_hlt_R794487ee
c0105118 enable_hlt_R9c7077bd
c0105264 machine_restart_Re6e3ef70
c01052e4 machine_halt_R9aa32630
c01052e8 machine_power_off_R091c824a
root@oasis:~# cat /proc/ksyms | grep c011e
c011e1b4 do_brk_R9eecde16
c011e778 invalidate_inode_pages_R93da71b9
c011e98c truncate_inode_pages_R721e7180
c011eb28 generic_buffer_fdatasync_Ra1c05088
------------< snip <------< snip <------< snip <------------

So call trace translates to something like:

filemap_nopage(), generic_file_mmap(), __down_failed_interruptible()

and we were somewhere in do_brk() when it oopsed.

Any ideas why this happened? Also, if I don't use msync() the problem goes
away so my guess is something's wrong with the msync() system call.

I've attached the small C program that caused this. Also, I can only get it
to oops once (after that I have to reboot again to get it to oops).

--=20

Regards
 Abraham

Best of all is never to have been born.  Second best is to die soon.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--VS++wcV0S1rZb1Fb
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="bug.main.c"


#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>

/* change to 0xb000 for monochrome displays */
#define TEXT_OFFSET		0xb8000
#define TEXT_LENGTH		(80 * 25 * 2)	// = 4000

#define ATTR_OFF        0	/* All attributes off */
#define ATTR_BOLD       1	/* Bold On */
#define ATTR_DIM        2	/* Dim (Is this really in the ANSI standard? */
#define ATTR_UNDERLINE  4	/* Underline (Monochrome Display Only */
#define ATTR_BLINK      5	/* Blink On */
#define ATTR_REVERSE    7	/* Reverse Video On */
#define ATTR_INVISIBLE  8	/* Concealed On */

#define COLOR_BLACK     0	/* Black */
#define COLOR_RED       1	/* Red */
#define COLOR_GREEN     2	/* Green */
#define COLOR_YELLOW    3	/* Yellow */
#define COLOR_BLUE      4	/* Blue */
#define COLOR_MAGENTA   5	/* Magenta */
#define COLOR_CYAN      6	/* Cyan */
#define COLOR_WHITE     7	/* White */

static const char *device = "/dev/mem";

int main ()
{
   int i,fd;
   unsigned char *text,*s,*d;
   char buf[TEXT_LENGTH],tmp[TEXT_LENGTH];

   /*
	* Map the text memory to something we can access
	*/

   if ((fd = open (device,O_RDWR | O_SYNC)) < 0)
	 {
		perror ("open()");
		exit (1);
	 }
   text = mmap (NULL,TEXT_LENGTH,PROT_READ | PROT_WRITE,MAP_SHARED,fd,TEXT_OFFSET);
   if (text == MAP_FAILED)
	 {
		perror ("mmap()");
		exit (1);
	 }

   /*
	* Do the tricks
	*/

   /* copy entire screen to temp buf */
   memcpy (buf,text,TEXT_LENGTH);

   /* flip buf upside-down */
//   memcpy (tmp,buf,TEXT_LENGTH);
//   for (i = 0, s = buf, d = tmp + TEXT_LENGTH - 80*2; i < 25/2; i++, s += 80*2, d -= 80*2)
//	 memcpy (d,s,80*2);
//   memcpy (buf,tmp,TEXT_LENGTH);

   /* set color to bright cyan */
   for (i = 1; i < TEXT_LENGTH; i += 2) buf[i] = /*COLOR_CYAN*/5;

   /* copy buf to screen */
   memcpy (text,buf,TEXT_LENGTH);
   msync (text,TEXT_LENGTH,MS_SYNC);

   /*
	* Clean up and exit
	*/

   munmap (text,TEXT_LENGTH);
   close (fd);
   exit (0);
}


--VS++wcV0S1rZb1Fb--

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7SXBkzNXhP0RCUqMRAlaWAJ0XL+k1HC11DPlM0fBNh2l+jcfyXgCdH9B8
XnAxK9nZgQw9C+KNMiTyRo0=
=Qa7o
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
