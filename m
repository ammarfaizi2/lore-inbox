Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTETXBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 19:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTETXBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 19:01:52 -0400
Received: from CPE-203-45-136-67.qld.bigpond.net.au ([203.45.136.67]:11269
	"EHLO oxcoda.safenetbox.biz") by vger.kernel.org with ESMTP
	id S261741AbTETXBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 19:01:46 -0400
Date: Wed, 21 May 2003 09:14:42 +1000
From: Menno Smits <menno@netbox.biz>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic with pptpd when mss > mtu
Message-Id: <20030521091442.1bfb41b6.menno@netbox.biz>
Organization: NetBox
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SERVER01/Oxcoda/AU(Release 5.0.12  |February 13, 2003) at
 21/05/2003 09:14:42 AM,
	Serialize by Router on SERVER01/Oxcoda/AU(Release 5.0.12  |February 13, 2003) at
 21/05/2003 09:14:43 AM,
	Serialize complete at 21/05/2003 09:14:43 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a kernel oops with 2.4.20 which seems to be related to the
PopTop PPTP server. When certain clients connect in (seems to be
Win98) and begin large data transfers the kernel will reliably oops.
The system crashes hard, the oops doesn't make it to the logs.

The problem appears to have been around for a while, although few
people have been affected. The following posts report similar
symptoms. There were no replies to either of them on linux-kernel.

http://www.cs.helsinki.fi/linux/linux-kernel/2002-10/0407.html (2.4.17)
http://www.cs.helsinki.fi/linux/linux-kernel/2001-28/0281.html (2.4.6!)

I have been able to deal with the issue by using the workaround
suggested in the the second post. That is, adding netfilter rules with
the TCPMSS target to limit the TCP MSS to PMTU - 40. Apparently the
problem is triggered by the MSS being bigger than the MTU (which is
750 in this case).

I have tcpdump logs for network traffic on both sides of the pptpd
server for several crash instances if that helps. I can perform other
tests and gather more information if required.

Decoded oops and module list follow. The crash is reproducable on a
variety of different hardware. PopTop version is 1.1.3-20030409. PPP
version is 2.4.1 with MPPE patches. 

skput:over: c4b63442:1338 put:1338 dev:<NULL>kernel BUG at skbuff.c:92!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01ca979>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000002d   ebx: c20acb20   ecx: 0000002d   edx: 00000000
esi: c20acb20   edi: 0000053a   ebp: c19f9380   esp: c246de00
ds: 0018   es: 0018   ss: 0018
Process pptpctrl (pid: 4681, stackpage=c246d000)
Stack: c0234480 c4b63442 0000053a 0000053a c023446b c4b6344a c20acb20 0000053a
       c4b63442 c19f9380 c19f9380 c25eb4a0 c2fb1813 c4b62e1e c19f9380 c25eb4a0
       c19f9380 c246c000 c058d3c0 c2fb1813 0000055b 0000055b c246df7c c4b62d9c
Call Trace:    [<c4b63442>] [<c4b6344a>] [<c4b63442>] [<c4b62e1e>] [<c4b62d9c>]
  [<c4b62bd6>] [<c4b6930d>] [<c4b68436>] [<c018fed6>] [<c018e7aa>] [<c018a226>]
  [<c018e614>] [<c0134066>] [<c0106e33>]
Code: 0f 0b 5c 00 a0 44 23 c0 83 c4 14 c3 8d 76 00 8b 54 24 04 8b
 
 
>>EIP; c01ca979 <skb_over_panic+29/38>   <=====
 
>>ebx; c20acb20 <_end+1def628/4814b08>
>>esi; c20acb20 <_end+1def628/4814b08>
>>ebp; c19f9380 <_end+173be88/4814b08>
>>esp; c246de00 <_end+21b0908/4814b08>
 
Trace; c4b63442 <END_OF_CODE+902b/????>
Trace; c4b6344a <END_OF_CODE+9033/????>
Trace; c4b63442 <END_OF_CODE+902b/????>
Trace; c4b62e1e <END_OF_CODE+8a07/????>
Trace; c4b62d9c <END_OF_CODE+8985/????>
Trace; c4b62bd6 <END_OF_CODE+87bf/????>
Trace; c4b6930d <END_OF_CODE+eef6/????>
Trace; c4b68436 <END_OF_CODE+e01f/????>
Trace; c018fed6 <pty_write+de/12c>
Trace; c018e7aa <write_chan+196/1f8>
Trace; c018a226 <tty_write+22e/2a8>
Trace; c018e614 <write_chan+0/1f8>
Trace; c0134066 <sys_write+96/118>
Trace; c0106e33 <system_call+33/40>
 
Code;  c01ca979 <skb_over_panic+29/38>
00000000 <_EIP>:
Code;  c01ca979 <skb_over_panic+29/38>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01ca97b <skb_over_panic+2b/38>
   2:   5c                        pop    %esp
Code;  c01ca97c <skb_over_panic+2c/38>
   3:   00 a0 44 23 c0 83         add    %ah,0x83c02344(%eax)
Code;  c01ca982 <skb_over_panic+32/38>
   9:   c4 14 c3                  les    (%ebx,%eax,8),%edx
Code;  c01ca985 <skb_over_panic+35/38>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c01ca988 <skb_under_panic+0/38>
   f:   8b 54 24 04               mov    0x4(%esp,1),%edx
Code;  c01ca98c <skb_under_panic+4/38>
  13:   8b 00                     mov    (%eax),%eax
 
 <0>Kernel panic: Aiee, killing interrupt handler!

-----

Module                  Size  Used by    Tainted: PF
ipt_MASQUERADE          2104   1  (autoclean)
ipt_REDIRECT            1368   4  (autoclean)
ipt_mark                 952   8  (autoclean)
ipt_MARK                1368   2  (autoclean)
iptable_mangle          2804   1  (autoclean)
ipt_state               1048  14  (autoclean)
ppp_deflate             3800   0  (autoclean)
zlib_inflate           21316   0  (autoclean) [ppp_deflate]
zlib_deflate           20888   0  (autoclean) [ppp_deflate]
ppp_mppe               23320   0  (autoclean)
bsd_comp                4920   0  (autoclean)
ppp_async               8288   0  (autoclean)
ppp_generic            20832   0  (autoclean) [ppp_deflate ppp_mppe bsd_comp ppp_async]
slhc                    5776   0  (autoclean) [ppp_generic]
e100                   78244   1
8139too                16616   1
mii                     3324   0  [8139too]
ipt_TCPMSS              3064   2  (autoclean)
ipt_REJECT              3576   1  (autoclean)
iptable_filter          2312   1  (autoclean)
ip_conntrack_h323       3600   1  (autoclean)
ip_nat_h323             3596   0  (unused)
ip_conntrack_irc        4080   1  (autoclean)
ip_nat_irc              3312   0  (unused)
ip_conntrack_ftp        5040   1  (autoclean)
ip_nat_ftp              4208   0  (unused)
iptable_nat            19672   4  [ipt_MASQUERADE ipt_REDIRECT ip_nat_h323 ip_nat_irc ip_nat_ftp]
ip_tables              13432  12  [ipt_MASQUERADE ipt_REDIRECT ipt_mark ipt_MARK iptable_mangle ipt_state ipt_TCPMSS ipt_REJECT iptable_filter iptable_nat]
ip_conntrack           33504   5  [ipt_MASQUERADE ipt_REDIRECT ipt_state ip_conntrack_h323 ip_nat_h323 ip_conntrack_irc ip_nat_irc ip_conntrack_ftp ip_nat_ftp iptable_nat]
keybdev                 2400   0  (unused)
hid                    15048   0  (unused)
input                   5056   0  [keybdev hid]
usbcore                70112   1  [hid]


Regards,
Menno Smits <menno@netbox.biz>

