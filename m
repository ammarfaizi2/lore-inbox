Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136326AbRDWBpz>; Sun, 22 Apr 2001 21:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136328AbRDWBpg>; Sun, 22 Apr 2001 21:45:36 -0400
Received: from ip166-70.fli-ykh.psinet.ne.jp ([210.129.166.70]:25027 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S136326AbRDWBpT>;
	Sun, 22 Apr 2001 21:45:19 -0400
Message-ID: <3AE38927.DE1CC68D@yk.rim.or.jp>
Date: Mon, 23 Apr 2001 10:45:11 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: xf86 server crash and VM problem(?)
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, excuse my rather length posting.
I have been trying to figure out what is wrong with my
setup  for the last few weeks and hit upon the slight chance
that there may be a VB related problem in the linux kernel.
Thus my post here.

PROBLEM:
        I can crash X server by the following step rather reliably.
        run X : whether I run this under xdm or X is irrelevant here.
        run netscape .

        Load the following page in netscape.
        This is a 250KB+ solaris 2 FAQ page.

        http://www.fwi.uva.nl/pub/solaris/solaris2.html

        While looking at this page using netscape,
        begin searching the successive occurences of
        the string "handle" using netscape "Find in page" menu.
        On the search of the second or the third occurence of the
        string in the said page, suddenly, the
        screen went blank and xdm restarts the X server.

        X server crashed!

        (Now of course, the setting of fonts and others
        will make the reproduction of this bug? rather
        difficult on other systems.)

SYSTEM:
Linux Kernel : 2.4.4-pre4.
        uname -a
        Linux duron 2.4.4-pre4 #15 Thu Apr 19 01:58:23 JST 2001 i686
unknown
System: Debian (testing).
CPU : AMD Duron 750.
Memory : 256MB  (+ Swap 80MB).
Video card: ATI rage 128.
Used X server: XFree86 3.3.6 XF86_SVGA (with fixes)

SUSPECT:

Now there can be various causes of this problem which I am
investigating, but I suspect a VM problem because of the
following:

 - from my investigation shown below, it seems that the X server was
   accessing an invalid(?) memory area, but I am not quite sure why it
can
   be an invalid memory area.

 - on linux kernel 2.4.[1-4], I once observed strange
   hung of my Xsession and when I tried to switch to another
   virtual console, I observed strange console messages like

    swap_free: Trying to free non-existent swap page
       Bad Swap Entry: 00000008
            // many //

    I also noticed a few posting about
    unresolved swap problems in linux kernel mailing list.

 - My manual procedure to repeat the bug causes the
   swap device to be used initially. That is the main memory
   was about to overflow or just began overflowing when the
   crash was observed (I think).

   I use xosview monitor program to monitor memory usage.
   When I start netscape "Used+Share" is about 100MB+.
   After loading the web page, it goes up to slighly abote 128MB.
   Afte the first search, it goes to close to 200MB. But
   in a transient manner, it goes up to close to 250MB and
   comes down to this 200MB value.
   So if I assume similar transient increase is expected for
   the subsequent string search,
   I think during the manual testing, the main memory (256MB)
   is exhausted and swap area was about to be touched.

  ( I run squid, nntpcache and xfs-xtt font server, dns and other
    daemons on  this machine
   and so memory usage is rather heavy.)


Of course, I am not ruling out the following possibilities:
 (i)  - the bug of the XFree86 3.3.6 XF_SVGA server,
       (ii) especially the ATI rage 128 driver portion,
 - and the bug hardware of my PC, such as
 (iii) memory
 (iv) video card itself.
 - (v) and possibly other reasons (I can't fathom yet).

So far, I think I could rule out the bug of (ii) since from what I
found out below.  The problem of the xserver occurs in a generic
bitblt copy routine for 16bit depth color frame.  (On the other hand,
it is hard to believe such a bug still exists in 3.3.6 server. Hmm..)

Also, by testing the memory with memtest86 over the last couple of
weeks on and off I think I can rule out (iii).

I am stumped for now here and posting this to solict
tips and hints for debugging.

(I am sticking to XFree86 3.3.6 server  because of
the following reason.
The linux swap bug and other subtle VM bug seem to be very
hard to reproduce. *IF* this probem I have observed
is caused by a linux VM bug, my setting then would
be an ideal setting to find out exactly what the VM bug is.)

Anyway, here is what I did and found out
(I tidied up the list. Actually, I did lot of
backtracking and trials and errors.)

1. After the crash, checked the output of xdm.log.
        (My X server is invoked via xdm.)
   Found that the X server died due to segmentation error.

2. Found that I set the core sizelimit to 0 and so no core
   was created. Too bad.

3. I changed  core size limit (using "ulimit -c")
   and re-started the xdm (and X11 server) so that
   a core will be roduced when the X server crashes.

4. I repeated the manual procedure
   to crash X server, i.e. the problematic netscape page access,
   the XFree86 X11 server crashed. Now a core file was produced. Good!

2. Tried to find out in which function the server dumped core.
   I ran gdb X core.
   At least I knew the function "cfb16DoBitbltCopy ()"
   was the cause.
   But I found out that the supplied X server binary has no debug
information.
   And so the information was sparce.

3. I needed more debug info. Otherwise, I would not know if the
   cause is a buggy X11 server, or my suspicion, a VM bug.

   So I donwloaded the Xfree86 3.3.6 distribution source and related
fixes
   from Xfree86 ftp sites. (My ATI Rage 128 card needs one of the
   supplied fixes.)
   Then I patched the source with the source and created the
   full XFree86 distribution.
   Full build took less than 1 hour (about 50 min.) on AMD Duron 750 MHz
PC.
   (Compare this with the almost a full day build on Sun3 !)

   Unfortunately, this produces the X server withotu any debug info.

4. I tweaked the XFree86 build procedure to obtain the problematic
   cfb16* functions compiled with  "-g" compilation flag, and
   re-linked the server. This should make it possible to
   capture symblic debug info from the core.

4. Anyway, I repeat the testing with this new
   X server with the debug info and got the symbolic trace here.

   Summary: a pointer access with the pointer value of
        0x42fdfcd8 seems to have caused the segmentation error during
        my testing.

duron:/etc/X11# gdb X core
GNU gdb 19990928
Copyright 1998 Free Software Foundation, Inc.
        ...
Core was generated by `/usr/bin/X11/X vt7 -bpp 16 -deferglyphs all -dpi
100 -auth /var/lib/xdm/authdir'.

    **** The above warning message seems to have been created by the
         overlaying via execv done by the X wrapper program?
         I got a similar core dump when I invoke the X program
         directly. So please do not be disturbed here.
         I attach the core dump case of directly invoked X server at the

         end.
    ****

    Program terminated with signal 11, Segmentation fault.
    Reading symbols from /lib/libm.so.6...done.
    Reading symbols from /lib/libdl.so.2...done.
    Reading symbols from /lib/libc.so.6...done.
    Reading symbols from /lib/ld-linux.so.2...done.
    Reading symbols from /lib/libnss_files.so.2...done.
    #0  0x820ea8b in cfb16DoBitbltCopy (pSrc=0x46e11008, pDst=0x8376c68,
alu=3,
        prgnDst=0x866ec20, pptSrc=0xbffff794, planemask=4294967295)
        at cfbbltC.c:547
    547                         bits = *psrc++;
    (gdb) print psrc
    $1 = (long unsigned int *) 0x42fdfcd8
    (gdb) where
    #0  0x820ea8b in cfb16DoBitbltCopy (pSrc=0x46e11008, pDst=0x8376c68,
alu=3,
        prgnDst=0x866ec20, pptSrc=0xbffff794, planemask=4294967295)
        at cfbbltC.c:547
    #1  0x8209861 in cfb16RestoreAreas (pPixmap=0x46e11008,
prgnRestore=0x866ec20,
        xorg=249, yorg=-33175, pWin=0x84f9920) at cfbbstore.c:146
    #2  0x82715a3 in miBSRestoreAreas ()
    #3  0x82737c0 in miSpriteRestoreAreas ()
    #4  0x826bec6 in miWindowExposures ()
    #5  0x8278e84 in miHandleValidateExposures ()
    #6  0x82790d6 in miMoveWindow ()
    #7  0x819ed7d in ConfigureWindow ()
    #8  0x8187e98 in ProcConfigureWindow ()
    #9  0x81877e3 in Dispatch ()
    #10 0x819627b in main ()
    #11 0x4005f16b in __libc_start_main () from /lib/libc.so.6
    (gdb) quit
    duron:/etc/X11# exit


5.  Now what is so special with this pointer value?

    >547                                bits = *psrc++;
    >(gdb) print psrc
    > $1 = (long unsigned int *) 0x42fdfcd8


    Since this is an AMD Duron 750MHz CPU, alignment issues
    should not arise. (Correct?)

    So I suspect that the routine somehow tries to
    access an area outside its process space (!?)

    However, is it the case? I investigated the memory
    allocation of X server by tracing system calls.

6.  Below is the VM-related system calls from the system call trace file

    of the X server I was running at the time when above
    core was created. (I only began tracing after the
    web page was loaded and searching of a string is performed once.)

    I used "strace -o X.trace.out -p pid-of-X-server".

    ishikawa@duron$ grep map X.trace.out
    08:33:49 old_mmap(NULL, 163840, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4132b000
    08:33:52 old_mmap(NULL, 47644672, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41353000
    08:33:52 munmap(0x4132b000, 163840)     = 0
    08:33:53 old_mmap(NULL, 48304128, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x440c3000
    08:33:53 munmap(0x41353000, 47644672)   = 0
    08:33:53 old_mmap(NULL, 47665152, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4132b000
    08:33:54 munmap(0x440c3000, 48304128)   = 0
    08:33:57 old_mmap(NULL, 47648768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x440a0000
    08:33:57 munmap(0x4132b000, 47665152)   = 0
    08:33:59 old_mmap(NULL, 69087232, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x46e11000
    08:33:59 munmap(0x440a0000, 47648768)   = 0
    ishikawa@duron$


   ( I didn't find sbrk(), I think this is long gone?
     mmap and old_unmap seem to be used for malloc/free, etc..
     I am not sure why mmap is old_mmap. This must be
     some glibc-related artifact.)

    Please note the usage pattern, that the value of old_mmap()
    will be used in the second next munmap() call.
    I suspect this is malloc()/free() access pattern.
    malloc/realloc seems to generate different pattern.

    Where does "$1 = (long unsigned int *) 0x42fdfcd8" fit
    in? The old_mmap() showed the following address ranges.

        0x4132b000
        0x440c3000
        0x4132b000
        0x440a0000
        0x46e11000

    So I think the 0x42fdfcd8 fits in one of the address ranges
    meaning that this should be in the valid address ranges of
    X server (?) : but I am not sure. I am not an expert on mmap/unmap.


7. On the other hand, considering that the swap area was probably be
   going to be touched, can it be that the heavy memory usage also by
    netscape at the time the X crashed may have triggered race/bug in
the
    VM subsystem of linux ?  I traced netscape process when I crashed
the
    X server.  This is the last part of the output from "grep map
    ns477.out" where ns477.out contained the strace output.

    I didn't find anything extraordinary here.

    08:34:00 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
    08:34:01 munmap(0x40021000, 4096)       = 0
    08:34:01 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
    08:34:01 munmap(0x40021000, 4096)       = 0
    08:34:01 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
    08:34:01 munmap(0x40021000, 4096)       = 0
    08:34:01 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
    08:34:01 munmap(0x40021000, 4096)       = 0
    08:34:01 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
    08:34:01 munmap(0x40021000, 4096)       = 0
    08:34:01 munmap(0x40020000, 4096)       = 0



So far the above is what I found out.

I am sending this out in the hope of narrowing down the
cause of the problem. (Again, my main aim is to see
if this is VM-related and if so, use this setup to try narrowing it down

to make linux 2.4.x more stable.)


Of course, I am not ruling out the following:
 >(i)  - the bug of the XFree86 XF_SVGA server,
      * possibly other parts of ATI rage 128 related portion might
        have a problem...
      * Maybe the xserver was overwriting itself in the loop?
        Can this be verified or denied by the output from the program?
        >Code: 8b 30 83 c0 04 89 85 7c ff ff ff 89 f0 8b 4d ac d3 e0 09
c2
       I have forgotten the trick someone mentioned about using objcdump

       to disassembly such sequence. Does anyone remember?

 >(iv) video card itself.
      * Can the on-board memory behave erratically?

 >(v) possibly other reasons.
      * don't know.

Any tips will be appreciated.

Here is the xdm.log.:

xdm.log
duron:/var/log# cat xdm.log

XFree86 Version 3.3.6 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: January 8 1999
        If the server is older than 6-12 months, or if your card is
newer
        than the above date, look for a newer version before reporting
        problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.4.4-pre4 i686 [ELF]
Configured drivers:
  SVGA: server for SVGA graphics adaptors (Patchlevel 1):
      NV1, STG2000, RIVA 128, RIVA TNT, RIVA TNT2, RIVA ULTRA TNT2,
      RIVA VANTA, RIVA ULTRA VANTA, RIVA INTEGRATED, GeForce 256,
      GeForce DDR, Quadro, ET4000, ET4000W32, ET4000W32i,
ET4000W32i_rev_b,
      ET4000W32i_rev_c, ET4000W32p, ET4000W32p_rev_a, ET4000W32p_rev_b,
      ET4000W32p_rev_c, ET4000W32p_rev_d, ET6000, ET6100, et3000, pvga1,

      wd90c00, wd90c10, wd90c30, wd90c24, wd90c31, wd90c33, gvga, r128,
ati,
      sis86c201, sis86c202, sis86c205, sis86c215, sis86c225, sis5597,
      sis5598, sis6326, sis530, sis620, sis300, sis630, sis540,
tvga8200lx,
      tvga8800cs, tvga8900b, tvga8900c, tvga8900cl, tvga8900d, tvga9000,

      tvga9000i, tvga9100b, tvga9200cxr, tgui9400cxi, tgui9420,
tgui9420dgi,
      tgui9430dgi, tgui9440agi, cyber9320, tgui9660, tgui9680, tgui9682,

      tgui9685, cyber9382, cyber9385, cyber9388, cyber9397, cyber9520,
      cyber9525, 3dimage975, 3dimage985, cyber9397dvd, blade3d,
cyberblade,
      clgd5420, clgd5422, clgd5424, clgd5426, clgd5428, clgd5429,
clgd5430,
      clgd5434, clgd5436, clgd5446, clgd5480, clgd5462, clgd5464,
clgd5465,
      clgd6205, clgd6215, clgd6225, clgd6235, clgd7541, clgd7542,
clgd7543,
      clgd7548, clgd7555, clgd7556, ncr77c22, ncr77c22e, cpq_avga,
mga2064w,
      mga1064sg, mga2164w, mga2164w AGP, mgag200, mgag100, mgag400,
oti067,
      oti077, oti087, oti037c, al2101, ali2228, ali2301, ali2302,
ali2308,
      ali2401, cl6410, cl6412, cl6420, cl6440, video7, ark1000vl,
ark1000pv,
      ark2000pv, ark2000mt, mx, realtek, s3_savage, s3_virge, AP6422,
AT24,
      AT3D, s3_svga, NM2070, NM2090, NM2093, NM2097, NM2160, NM2200,
      ct65520, ct65525, ct65530, ct65535, ct65540, ct65545, ct65546,
      ct65548, ct65550, ct65554, ct65555, ct68554, ct69000, ct64200,
      ct64300, mediagx, V1000, V2100, V2200, p9100, spc8110, i740,
i740_pci,
      Voodoo Banshee, Voodoo3, smi, generic
(using VT number 7)

XF86Config: /root/XF86Config
(**) stands for supplied, (--) stands for probed/default values
(**) XKB: keymap: "xfree86(us)" (overrides other XKB settings)
(**) Mouse: type: PS/2, device: /dev/psaux, buttons: 3
(**) SVGA: Graphics device ID: "r128"
(**) SVGA: Monitor ID: "iiyama a901h"
(**) SVGA: Graphics device ID: "r128"
(**) SVGA: Monitor ID: "iiyama a901h"
Warning: The directory "/usr/lib/X11/fonts/Type1/" does not exist.
         Entry deleted from font path.
Warning: The directory "/usr/lib/X11/fonts/Speedo/" does not exist.
         Entry deleted from font path.
(**) FontPath set to
"/usr/X11R6/lib/X11/fonts/misc/,/usr/lib/X11/fonts/misc/,/usr/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/75dpi/,tcp/localhost:7100"

(--) SVGA: PCI: ATI Rage 128 RF rev 0, Memory @ 0xe0000000, MMIO @
0xefafc000, I/O @ 0xb800
(--) SVGA: r128: PLL parameters: rf=2950 rd=65 min=12500 max=25000;
xclk=10300
(--) SVGA: chipset:  r128
(--) SVGA: videoram: 16384k
(**) SVGA: Option "dac_8_bit"
(**) SVGA: Using 16 bpp, Depth 16, Color weight: 565
(--) SVGA: Maximum allowed dot-clock: 250.000 MHz
(**) SVGA: Mode "1280x1024": mode clock = 181.750
(**) SVGA: Mode "1024x768": mode clock = 115.500
(**) SVGA: Mode "800x600": mode clock =  69.650
(**) SVGA: Mode "640x480": mode clock =  45.800
(**) SVGA: Mode "1600x1200": mode clock = 220.000
(--) SVGA: Resolution 1600x1200 too large for virtual 1280x1024
(--) SVGA: Removing mode "1600x1200" from list of valid modes.
(**) SVGA: Mode "1152x864": mode clock = 137.650
(**) SVGA: Virtual resolution set to 1280x1024
(--) SVGA: SpeedUp code selection modified because virtualX != 1024
(--) SVGA: r128: ATI Rage 128 RF (AGP)
(--) SVGA: r128: Using hardware cursor
(--) SVGA: r128: Acceleration enabled
(--) SVGA: Using XAA (XFree86 Acceleration Architecture)
(--) SVGA: XAA: Solid filled rectangles
(--) SVGA: XAA: Screen-to-screen copy
(--) SVGA: XAA: 8x8 color expand pattern fill
(--) SVGA: XAA: Indirect CPU to screen color expansion (imagetext,
polytext)
(--) SVGA: XAA: Using 10 128x128 areas for pixmap caching
(--) SVGA: XAA: Caching tiles and stipples
(--) SVGA: XAA: Horizontal and vertical lines and segments
System: `/usr/X11R6/lib/X11/xkb/xkbcomp -w 1 -R/usr/X11R6/lib/X11/xkb
-xkm -m us -em1 "The XKEYBOARD keymap compiler (xkbcomp) reports:" -emp
"> " -eml "Errors from xkbcomp are not fatal to the X server"
keymap/xfree86 compiled/xfree86.xkm'
Caught signal 11.

Server aborting...

eip: 0820ea8b   eflags: 00013256
eax: 42fdfcd8   ebx: 4023d3f0   ecx: 00000010   edx: 00000000
esi: 00000000   edi: 00000010   ebp: bffff76c   esp: bffff6d4
Stack: ffffffff 0866ec20 bffff794 08267ebc 0846c7e8 42fdfcd8 000004ed
012682eb
       08646d40 0000027a 000003be 084fd108 00000002 bffff798 000000f9
00000000
       0864b110 00000010 00000001 00000000 000001f9 0000ffff ffff0000
4023ddf0
       42fe04c0 00000001 00000001 0000013d 00000028 00000001 00000000
086650e0
Call Trace: 08267ebc 08209861 082698ae 082715a3 082737c0 0812e3c6
0826bec6
       081ab49e 081ab49e 08278e84 082678eb 0826be98 082790d6 082790c2
0818f902
       0819ed7d 0819779d 081ae98e 0818d42e 08187e98 081877e3 0818786b
0826c66a
       0826ecd6 0820e462 080edcc3 080edcef 081ab427 0819643d 081966a7
08196394
       08272774 08187758 08196262 0819627b 082d1af0 08081440 08081461
08195dc8
       082d1af0 08081440
Code: 8b 30 83 c0 04 89 85 7c ff ff ff 89 f0 8b 4d ac d3 e0 09 c2

Please forward information about this crash to XFree86@XFree86.org
including the _full_ output of the X server.

To analyse the crash dump, please type

        gdb /usr/bin/X11/X /etc/X11/core
        where

and include this output in your report.  Thanks!

xdm error (pid 18157): Server for display :0 terminated unexpectedly:
2816

    Cf.
    In the case of X server directly invoked (instead of
    xdm and other X wrapper.), I get the folloing output from X.
    it was run as
            ./X >& /tmp/t.x.out &

    In this case, X crashed on the third search and
    the crash occurred in a slightly different
    place in the same routine.

            ...

    Caught signal 11.

    Server aborting...

    eip: 0820e980       eflags: 00013293
    eax: 00000002       ebx: 40233388   ecx: 4685a708   edx: 0000005a
    esi: 000003f4       edi: bffff7f8   ebp: bffff7cc   esp: bffff734
    Stack: ffffffff 085b5948 bffff7f4 08267ebc 087aff98 4685a708
000004b8 012682eb
           087bf630 00000188 0000005a 087d2aa8 00000002 bffff7f8
000000c4 00000000
           000001fa 087d2680 00000000 00000000 000001fa 00000000
00000000 40233d88
           4685aef0 00000001 00000001 0000005b 00000028 00000001
00000000 087c0940
    Call Trace: 08267ebc 08209861 082698ae 082715a3 082737c0 0812e3c6
0826bec6
           081ab49e 081ab49e 08278e84 082678eb 0826be98 082790d6
082790c2 0818f902
           0819ed7d 0819779d 081ae98e 0818d42e 08187e98 081877e3
0818786b 0826c66a
           0826ecd6 0820e462 080edcc3 080edcef 081ab427 0819643d
081966a7 08196394
           08272774 08187758 08196262 0819627b 082d1af0 08081440
08081461 08195dc8
           082d1af0 08081440
    Code: 8b 01 89 03 83 c3 04 83 c1 04 89 8d 7c ff ff ff 8b bd 7c ff

    Please forward information about this crash to XFree86@XFree86.org
    including the _full_ output of the X server.

    To analyse the crash dump, please type

            gdb ./X /etc/X11/core
            where

    and include this output in your report.      Thanks!

    Also, analyzing the core in this case
    produced the following.

    Core was generated by `./X'.
    Program terminated with signal 5, Trace/breakpoint trap.
    Reading symbols from /lib/libm.so.6...done.
    Reading symbols from /lib/libdl.so.2...done.
    Reading symbols from /lib/libc.so.6...done.
    Reading symbols from /lib/ld-linux.so.2...done.
    Reading symbols from /lib/libnss_files.so.2...done.
    #0  0x820e980 in cfb16DoBitbltCopy (pSrc=0x492a9008, pDst=0x8376c68,
alu=3,
        prgnDst=0x85b5948, pptSrc=0xbffff7f4, planemask=4294967295)
        at cfbbltC.c:499
    499                             pdst++; psrc++;)
    (gdb) print pdst
    $1 = (long unsigned int *) 0x40233388
    (gdb) print psrc
    $2 = (long unsigned int *) 0x4685a708
    (gdb) list 490
    485                     {
    486                         asm ("moveml
%1+,#0x0c0f;moveml#0x0c0f,%0"
    487                              : "=m" (*(char *)pdst)
    488                              : "m" (*(char *)psrc)
    489                              : "d0", "d1", "d2", "d3",
    490                                "a2", "a3");
    491                         pdst += 6;
    492                     }
    493                     nl += 6;
    494                     while (nl--)
    (gdb) print nl
    $3 = 506
    (gdb) list
    495                         *pdst++ = *psrc++;
    496 #endif
    497                     DuffL(nl, label1,
    498                             *pdst = MROP_SOLID (*psrc, *pdst);
    499                             pdst++; psrc++;)
    500 #endif

        (So it looks the core was dumped when the program was
        executing the loop in (macro) DuffL().

[end of memo]


