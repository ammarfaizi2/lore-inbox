Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbTAGOTU>; Tue, 7 Jan 2003 09:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTAGOTU>; Tue, 7 Jan 2003 09:19:20 -0500
Received: from sys-209.inet6.fr ([62.210.110.209]:64714 "EHLO ns1.inet6.fr")
	by vger.kernel.org with ESMTP id <S267390AbTAGOTP>;
	Tue, 7 Jan 2003 09:19:15 -0500
Message-ID: <3E1AE3E8.5010301@inet6.fr>
Date: Tue, 07 Jan 2003 15:27:52 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021223
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [MM BUG report] 2.4.20-ac2 mm/filemap.c truncate_complete_page BUG()
Content-Type: multipart/mixed;
 boundary="------------070309080407030504080403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070309080407030504080403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This happened 3 times, each time some (1-3) days after bootup

ksymoops output is attached

## Hardware/Kernel Config

The config was just upgraded from the following (where everything worked 
nicely for weeks between reboots).

Bi-Celeron 433 on Abit BP6 wit 256 Mb RAM and latest RedHat 7.3 kernel 
(at that time 2.4.18-18).

to this one :

Single Athlon XP 1700+ on ECS K7S5A (SiS735 chipset) with 128 Mb RAM and 
2.4.20-ac2 kernel.

This was a drop in replacemnt (same disks, same software).

## Modules loaded (yes there are many of them)

Here are the modules loaded on current config :

Module                  Size  Used by    Not tainted
smbfs                  37664   1 (autoclean)
nfsd                   75872   8 (autoclean)
lockd                  55936   1 (autoclean) [nfsd]
sunrpc                 74804   1 (autoclean) [nfsd lockd]
parport_pc             28904   1 (autoclean)
lp                      7552   0 (autoclean)
parport                35104   1 (autoclean) [parport_pc lp]
ppp_deflate             3904   2 (autoclean)
zlib_inflate           21664   0 (autoclean) [ppp_deflate]
zlib_deflate           20864   0 (autoclean) [ppp_deflate]
bsd_comp                5088   0 (autoclean)
it87                    8256   0
i2c-proc                8192   0 [it87]
i2c-isa                 1892   0 (unused)
i2c-core               20800   0 [it87 i2c-proc i2c-isa]
cls_u32                 5572   1 (autoclean)
cls_fw                  3072   1 (autoclean)
sch_sfq                 4416   2 (autoclean)
sch_cbq                13952   1 (autoclean)
ipt_MARK                1408  18 (autoclean)
iptable_mangle          2816   1 (autoclean)
ipt_TCPMSS              3040   1 (autoclean)
ipt_limit               1536   2 (autoclean)
ipt_REJECT              3584   2 (autoclean)
n_hdlc                  7136   1
ppp_synctty             6272   1
ipt_state               1088  19 (autoclean)
ipt_unclean             7552   1 (autoclean)
ipt_LOG                 4160   5 (autoclean)
ip_nat_ftp              3776   0 (unused)
ip_conntrack_ftp        4864   1
iptable_nat            18868   2 (autoclean) [ip_nat_ftp]
ip_conntrack           24748   3 (autoclean) [ipt_state ip_nat_ftp 
ip_conntrack_ftp iptable_nat]
ppp_async               8032   1
ppp_generic            19244   6 [ppp_deflate bsd_comp ppp_synctty 
ppp_async]
iptable_filter          2336   1 (autoclean)
slhc                    6412   1 [ppp_generic]
ip_tables              13568  12 [ipt_MARK iptable_mangle ipt_TCPMSS 
ipt_limit ipt_REJECT ipt_state ipt_unclean ipt_LOG iptable_nat 
iptable_filter]
sis900                 14756   1
3c59x                  27368   1
af_packet              13800   2 (autoclean)
ide-cd                 31776   0 (autoclean)
cdrom                  31968   0 (autoclean) [ide-cd]
md                     48768   0 (unused)
loop                   10128   0 (autoclean)
lvm-mod                49664   8 (autoclean)
usb-ohci               20192   0 (unused)
usbcore                71424   1 [usb-ohci]

Lm_sensors (it87 module here) was already used on previous config and 
upgraded to v2.7.0 with i2c-2.7.0.
I can prevent lm_sensors and i2c modules from loading if needed.

The box is under heavy memory pressure with quasi constant swap in swap 
out (personnal NAT box with numerous services running nfs, squid, apache 
...). Current vmstat output is :

   procs                      memory    swap          io     
system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  
sy  id
 0  0  0  63888   6036   1628  27112  28  36   174   227   37    33   
8   4  88

-> si = 28, so = 36

The perf is not stellar but is expected to be so under this kind of 
memory pressure (512 MB stick was already ordered when first Oops came). 
What's not expected is the oops attached.
The system does not crash but the process involved (always rrdtool 
launched by crontab for the 3 Oopps) is stuck in D state and each 
following process  trying to access the same files are stucked in D 
states too (as rrdtool is called each minute to update its databases and 
graph nice graphs it leads to load average jumping to 200 in a matter of 
3 hours...).

The code involved in filemap.c truncate_complete_page are the very first 
lines :

[...]
        /* Page has already been removed from processes, by vmtruncate()  */
        if (page->pte_chain)
                BUG();
[...]


For the record (probably not important) last time I checked the rrdtool 
processes stucked in D state were the ones that graphed the load average 
(so the file that posed problem was probably not the database but one of 
the resulting png file).

Question : how do I get the current syscall of a process stucked in D 
state remotely (Sysrq can do it but there's no screen attached so if I 
could get the info remotely that would spare me temporary screen 
relocations...).

I've a stock 2.4.20 kernel already compiled for testing (will be used on 
next reboot, lm_sensors and i2c modules won't load).

LB.

--------------070309080407030504080403
Content-Type: text/plain;
 name="ksymoops.out"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ksymoops.out"

a3N5bW9vcHMgMi40LjQgb24gaTY4NiAyLjQuMjAtYWMyLiAgT3B0aW9ucyB1c2VkCiAgICAg
LXYgdm1saW51eCAoc3BlY2lmaWVkKQogICAgIC1rIC9wcm9jL2tzeW1zIChkZWZhdWx0KQog
ICAgIC1sIC9wcm9jL21vZHVsZXMgKGRlZmF1bHQpCiAgICAgLW8gL2xpYi9tb2R1bGVzLzIu
NC4yMC1hYzIvIChkZWZhdWx0KQogICAgIC1tIC9ib290L1N5c3RlbS5tYXAtMi40LjIwLWFj
MiAoZGVmYXVsdCkKCkphbiAgNiAwMToxMzowNCB0d2lucyBrZXJuZWw6IGtlcm5lbCBCVUcg
YXQgZmlsZW1hcC5jOjI0MiEKSmFuICA2IDAxOjEzOjA0IHR3aW5zIGtlcm5lbDogaW52YWxp
ZCBvcGVyYW5kOiAwMDAwCkphbiAgNiAwMToxMzowNCB0d2lucyBrZXJuZWw6IENQVTogICAg
MApKYW4gIDYgMDE6MTM6MDQgdHdpbnMga2VybmVsOiBFSVA6ICAgIDAwMTA6WzxjMDEyNTBh
Yz5dICAgIE5vdCB0YWludGVkClVzaW5nIGRlZmF1bHRzIGZyb20ga3N5bW9vcHMgLXQgZWxm
MzItaTM4NiAtYSBpMzg2CkphbiAgNiAwMToxMzowNCB0d2lucyBrZXJuZWw6IEVGTEFHUzog
MDAwMTAyODYKSmFuICA2IDAxOjEzOjA0IHR3aW5zIGtlcm5lbDogZWF4OiBjNTU2M2RkOCAg
IGVieDogYzEwYjI5NjggICBlY3g6IGMxMGIyOTY4ICAgZWR4OiBjNGIyNTdlOApKYW4gIDYg
MDE6MTM6MDQgdHdpbnMga2VybmVsOiBlc2k6IGM1NGJlMWE4ICAgZWRpOiAwMDAwMDAwMCAg
IGVicDogMDAwMDAwMDAgICBlc3A6IGM1NTYzZDc4CkphbiAgNiAwMToxMzowNCB0d2lucyBr
ZXJuZWw6IGRzOiAwMDE4ICAgZXM6IDAwMTggICBzczogMDAxOApKYW4gIDYgMDE6MTM6MDQg
dHdpbnMga2VybmVsOiBQcm9jZXNzIHJyZHRvb2wgKHBpZDogMjU3NDUsIHN0YWNrcGFnZT1j
NTU2MzAwMCkKSmFuICA2IDAxOjEzOjA0IHR3aW5zIGtlcm5lbDogU3RhY2s6IGMxMGIyOTY4
IGMwMTI1MjNhIGMxMGIyOTY4IDAwMDAwMDAwIDAwMDAwMDAxIGM1NTYzZGQ4IDAwMDAwMDAw
IDQwNDAwMDAwCkphbiAgNiAwMToxMzowNCB0d2lucyBrZXJuZWw6ICAgICAgICA0MDAxNjAw
MCBjMzU2NDQwNCBjMGUzYTAwMCBjMWJjNTg3NCAwMDAwMDAwMCAwMDAwMDA4MSBjMzA3YjMw
MCAwMDAwMDAwMApKYW4gIDYgMDE6MTM6MDQgdHdpbnMga2VybmVsOiAgICAgICAgYzMwN2Iz
NWMgYzAxYmZlZmIgNDAwMTUwMDAgMDAwMDAwMDAgYzU1NjNkZDggMDAwMDAwMDAgYzU0YmUx
YTggYzAxMjUyZGIKSmFuICA2IDAxOjEzOjA0IHR3aW5zIGtlcm5lbDogQ2FsbCBUcmFjZTog
ICAgWzxjMDEyNTIzYT5dIFs8YzAxYmZlZmI+XSBbPGMwMTI1MmRiPl0gWzxjMDEyMzA1OD5d
IFs8YzAxNDdmNjQ+XQpKYW4gIDYgMDE6MTM6MDQgdHdpbnMga2VybmVsOiAgIFs8YzAxNTky
M2I+XSBbPGMwMTI2ZDhiPl0gWzxjMDEyNmRiOT5dIFs8YzAxNDgwZDQ+XSBbPGMwMTMyZmZk
Pl0gWzxjMDEzMmQ1Yz5dCkphbiAgNiAwMToxMzowNCB0d2lucyBrZXJuZWw6ICAgWzxjMDEz
MzZiNj5dIFs8YzAxM2VjYTQ+XSBbPGMwMTEzMTExPl0gWzxjMDFiZmEwZT5dIFs8YzAxMzQ0
YjQ+XSBbPGMwMTM0N2UxPl0KSmFuICA2IDAxOjEzOjA0IHR3aW5zIGtlcm5lbDogICBbPGMw
MTA2YzhiPl0KSmFuICA2IDAxOjEzOjA0IHR3aW5zIGtlcm5lbDogQ29kZTogMGYgMGIgZjIg
MDAgYmUgYTQgMjAgYzAgOGIgNDMgMzAgODUgYzAgNzQgMGUgNmEgMDAgNTMgZTggYWQKCj4+
RUlQOyBjMDEyNTBhYyA8dHJ1bmNhdGVfY29tcGxldGVfcGFnZStjLzYwPiAgIDw9PT09PQpU
cmFjZTsgYzAxMjUyM2EgPHRydW5jYXRlX2xpc3RfcGFnZXMrMTNhLzFhMD4KVHJhY2U7IGMw
MWJmZWZiIDxrZnJlZV9za2JtZW0rYi82MD4KVHJhY2U7IGMwMTI1MmRiIDx0cnVuY2F0ZV9p
bm9kZV9wYWdlcyszYi83MD4KVHJhY2U7IGMwMTIzMDU4IDx2bXRydW5jYXRlKzk4LzEzMD4K
VHJhY2U7IGMwMTQ3ZjY0IDxpbm9kZV9zZXRhdHRyKzI0L2QwPgpUcmFjZTsgYzAxNTkyM2Ig
PGV4dDNfc2V0YXR0cisxM2IvMTgwPgpUcmFjZTsgYzAxMjZkOGIgPGZpbGVtYXBfbm9wYWdl
K2JiLzIwMD4KVHJhY2U7IGMwMTI2ZGI5IDxmaWxlbWFwX25vcGFnZStlOS8yMDA+ClRyYWNl
OyBjMDE0ODBkNCA8bm90aWZ5X2NoYW5nZSs1NC8xMDA+ClRyYWNlOyBjMDEzMmZmZCA8cHRl
X2NoYWluX2FsbG9jK2QvMzA+ClRyYWNlOyBjMDEzMmQ1YyA8cGFnZV9hZGRfcm1hcCsyYy84
MD4KVHJhY2U7IGMwMTMzNmI2IDxkb190cnVuY2F0ZSs0Ni82MD4KVHJhY2U7IGMwMTNlY2E0
IDxvcGVuX25hbWVpKzNkNC80ZjA+ClRyYWNlOyBjMDExMzExMSA8X193YWtlX3VwKzQxLzYw
PgpUcmFjZTsgYzAxYmZhMGUgPHNvY2tfZGVmX3dyaXRlX3NwYWNlKzJlLzcwPgpUcmFjZTsg
YzAxMzQ0YjQgPGZpbHBfb3BlbiszNC82MD4KVHJhY2U7IGMwMTM0N2UxIDxzeXNfb3Blbisz
MS84MD4KVHJhY2U7IGMwMTA2YzhiIDxzeXN0ZW1fY2FsbCszMy8zOD4KQ29kZTsgIGMwMTI1
MGFjIDx0cnVuY2F0ZV9jb21wbGV0ZV9wYWdlK2MvNjA+CjAwMDAwMDAwIDxfRUlQPjoKQ29k
ZTsgIGMwMTI1MGFjIDx0cnVuY2F0ZV9jb21wbGV0ZV9wYWdlK2MvNjA+ICAgPD09PT09CiAg
IDA6ICAgMGYgMGIgICAgICAgICAgICAgICAgICAgICB1ZDJhICAgICAgPD09PT09CkNvZGU7
ICBjMDEyNTBhZSA8dHJ1bmNhdGVfY29tcGxldGVfcGFnZStlLzYwPgogICAyOiAgIGYyIDAw
IGJlIGE0IDIwIGMwIDhiICAgICAgcmVwbnogYWRkICViaCwweDhiYzAyMGE0KCVlc2kpCkNv
ZGU7ICBjMDEyNTBiNSA8dHJ1bmNhdGVfY29tcGxldGVfcGFnZSsxNS82MD4KICAgOTogICA0
MyAgICAgICAgICAgICAgICAgICAgICAgIGluYyAgICAlZWJ4CkNvZGU7ICBjMDEyNTBiNiA8
dHJ1bmNhdGVfY29tcGxldGVfcGFnZSsxNi82MD4KICAgYTogICAzMCA4NSBjMCA3NCAwZSA2
YSAgICAgICAgIHhvciAgICAlYWwsMHg2YTBlNzRjMCglZWJwKQpDb2RlOyAgYzAxMjUwYmMg
PHRydW5jYXRlX2NvbXBsZXRlX3BhZ2UrMWMvNjA+CiAgMTA6ICAgMDAgNTMgZTggICAgICAg
ICAgICAgICAgICBhZGQgICAgJWRsLDB4ZmZmZmZmZTgoJWVieCkKQ29kZTsgIGMwMTI1MGJm
IDx0cnVuY2F0ZV9jb21wbGV0ZV9wYWdlKzFmLzYwPgogIDEzOiAgIGFkICAgICAgICAgICAg
ICAgICAgICAgICAgbG9kcyAgICVkczooJWVzaSksJWVheAo=
--------------070309080407030504080403--

