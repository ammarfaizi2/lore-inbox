Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbTC1PqD>; Fri, 28 Mar 2003 10:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbTC1PqD>; Fri, 28 Mar 2003 10:46:03 -0500
Received: from mail.gmx.net ([213.165.65.60]:26424 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263022AbTC1Ppz>;
	Fri, 28 Mar 2003 10:45:55 -0500
Message-Id: <5.2.0.9.2.20030328164837.019c0968@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 28 Mar 2003 17:01:21 +0100
To: Zwane Mwaikambo <zwane@linuxpower.ca>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.66-mm1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Ed Tomlinson <tomlins@cam.org>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.50.0303280942420.2884-100000@montezuma.mastecen
 de.com>
References: <5.2.0.9.2.20030328152305.019b3e70@pop.gmx.net>
 <20030327205912.753c6d53.akpm@digeo.com>
 <5.2.0.9.2.20030328152305.019b3e70@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_47238343==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_47238343==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 09:56 AM 3/28/2003 -0500, Zwane Mwaikambo wrote:
>On Fri, 28 Mar 2003, Mike Galbraith wrote:
>
> > >hm, this is an 'impossible' scenario from the scheduler code POV. Whenever
> > >we deactivate a task, we remove it from the runqueue and set p->array to
> > >NULL. Whenever we activate a task again, we set p->array to non-NULL. A
> > >double-deactivate is not possible. I tried to reproduce it with various
> > >scheduler workloads, but didnt succeed.
> > >
> > >Mike, do you have a backtrace of the crash you saw?
> >
> > No, I didn't save it due to "grubby fingerprints".
>
>Hmm i think i may have his this one but i never posted due to being unable
>to reproduce it on a vanilla kernel or the same kernel afterwards (which
>was hacked so i won't vouch for it's cleanliness). I think preempt
>might have bitten him in a bad place (mine is also CONFIG_PREEMPT), is it
>possible that when we did the task_rq_unlock we got preempted and when we
>got back we used the local variable requeue_waker which was set before
>dropping the lock, and therefore might not be valid anymore due to
>scheduler decisions done after dropping the runqueue lock?

Dunno.  I did have one lying around.  The attached one was while printing 
out array switch latency after starvation timeout.  Others happened while 
printing wakeup stats for p->state > 1 tasks in scheduler_tick() [under 
lock w/ wakeup disabled in printk.c].  It's nothing I did to the scheduler 
;-) I don't think, but this was in 65-mm3-twiddle-twiddle-twiddle.

>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
>c011b8d9
>*pde = 00000000
>Oops: 0000 [#1]
>CPU:    0
>EIP:    0060:[<c011b8d9>]    Not tainted
>EFLAGS: 00010046
>EIP is at try_to_wake_up+0x1e9/0x4f0
>eax: c055a000   ebx: c04e5aa0   ecx: c0552fc0   edx: c04e5aa0
>esi: 00000000   edi: 00000000   ebp: c055bee4   esp: c055beb8
>ds: 007b   es: 007b   ss: 0068
>Process swapper (pid: 0, threadinfo=c055a000 task=c04e5aa0)
>Stack: 00000001 c055a000 c0552fc0 00000000 cb1a0000 00000001 00000001 
>00000002
>        00000000 c04e88e4 00000001 c055bf08 c011d172 c1694700 00000001 
> 00000000
>        c04e88e4 c04e88dc c055a000 00000001 c055bf3c c011d203 c04e88dc 
> 00000001
>Call Trace:
>  [<c011d172>] __wake_up_common+0x32/0x60
>  [<c011d203>] __wake_up+0x63/0xb0
>  [<c0122fb5>] release_console_sem+0x165/0x170
>  [<c0122d7b>] printk+0x1eb/0x270
>  [<c015e210>] invalidate_bh_lru+0x0/0x60
>  [<c015e210>] invalidate_bh_lru+0x0/0x60
>  [<c015e210>] invalidate_bh_lru+0x0/0x60
>  [<c01163f2>] smp_call_function_interrupt+0x42/0xb0
>  [<c015e210>] invalidate_bh_lru+0x0/0x60
>  [<c0106eb0>] default_idle+0x0/0x40
>  [<c010a41a>] call_function_interrupt+0x1a/0x20
>  [<c0106eb0>] default_idle+0x0/0x40
>  [<c0106ede>] default_idle+0x2e/0x40
>  [<c0106f6a>] cpu_idle+0x3a/0x50
>  [<c0105000>] rest_init+0x0/0x80
>
>Code: 8b 06 48 89 06 8b 4a 24 8b 42 20 89 01 89 48 04 8b 4a 18 8d
>
>0xc011b8d9 is in try_to_wake_up (kernel/sched.c:282).
>277     /*
>278      * Adding/removing a task to/from a priority array:
>279      */
>280     static inline void dequeue_task(struct task_struct *p, 
>prio_array_t *array)
>281     {
>282             array->nr_active--;
>283             list_del(&p->run_list);
>284             if (list_empty(array->queue + p->prio))
>285                     __clear_bit(p->prio, array->bitmap);
>286     }

Same spot.

         -Mike 
--=====================_47238343==_
Content-Type: text/plain; name="oops.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oops.txt"

TG9nbGV2ZWwgc2V0IHRvIDkKaG1tLi4gMjg5IG1zCmhtbS4uIDYgbXMKaG1tLi4gNCBtcwpobW0u
LiA3IG1zCmhtbS4uIDEzIG1zCmhtbS4uIDE1IG1zClVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5V
TEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAKIHByaW50
aW5nIGVpcDoKYzAxMTRkMGEKKnBkZSA9IDAwMDAwMDAwCk9vcHM6IDAwMDIgWyMxXQpDUFU6ICAg
IDAKRUlQOiAgICAwMDYwOls8YzAxMTRkMGE+XSAgICBOb3QgdGFpbnRlZCBWTEkKRUZMQUdTOiAw
MDAxMDAwNgpFSVAgaXMgYXQgdHJ5X3RvX3dha2VfdXArMHgxZTIvMHgyNTgKZWF4OiAwMDAwMDAw
OCAgIGVieDogYzAyY2IzYzggICBlY3g6IGMwZGNmMzYwICAgZWR4OiBjMGRjZjM2MAplc2k6IGMw
YzI0MDAwICAgZWRpOiAwMDAwMDAwMCAgIGVicDogYzBjMjVlZDQgICBlc3A6IGMwYzI1ZWI4CmRz
OiAwMDdiICAgZXM6IDAwN2IgICBzczogMDA2OApQcm9jZXNzIGdjYyAocGlkOiA1OTIsIHRocmVh
ZGluZm89YzBjMjQwMDAgdGFzaz1jMGRjZjM2MCkKU3RhY2s6IDAwMDAwMDAxIDAwMDAwMDAxIGMw
Mjk4ZmY0IGMwYzI1ZWQwIDAwMDAwMDAxIDAwMDAwMDAxIDAwMDAwMDAyIGMwYzI1ZWU4IAogICAg
ICAgYzAxMTU4ODcgYzdiOGEwYTAgMDAwMDAwMDMgMDAwMDAwMDAgYzBjMjVmMDggYzAxMTU4YzIg
YzJkODFlNWMgMDAwMDAwMDMgCiAgICAgICAwMDAwMDAwMCBjMGMyNDAwMCAwMDAwMDA4MiBjMDI5
OGZlOCBjMGMyNWYyMCBjMDExNTk0YSBjMDI5OGZmMCAwMDAwMDAwMyAKQ2FsbCBUcmFjZToKIFs8
YzAxMTU4ODc+XSBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgxNy8weDFjCiBbPGMwMTE1OGMyPl0g
X193YWtlX3VwX2NvbW1vbisweDM2LzB4NTAKIFs8YzAxMTU5NGE+XSBfX3dha2VfdXBfbG9ja2Vk
KzB4ZS8weDE0CiBbPGMwMTA3Y2RjPl0gX19kb3duX3RyeWxvY2srMHgzNC8weDU0CiBbPGMwMTA3
ZDFiPl0gX19kb3duX2ZhaWxlZF90cnlsb2NrKzB4Ny8weGMKIFs8YzAxMTkyOGI+XSAudGV4dC5s
b2NrLnByaW50aysweDUvMHgyYQogWzxjMDExNTVmMD5dIHNjaGVkdWxlKzB4MTNjLzB4Mzc4CiBb
PGMwMTFhYjA3Pl0gc3lzX3dhaXQ0KzB4YWIvMHgyMzQKIFs8YzAxMWFjNWQ+XSBzeXNfd2FpdDQr
MHgyMDEvMHgyMzQKIFs8YzAxMTU4NzA+XSBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgwLzB4MWMK
IFs8YzAxMTU4NzA+XSBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgwLzB4MWMKIFs8YzAxMDhiNWY+
XSBzeXNjYWxsX2NhbGwrMHg3LzB4YgoKQ29kZTogZmYgNDggMTQgOGIgNDAgMDggYTggMDggNzQg
MDcgZTggM2UgMGIgMDAgMDAgODkgZjYgODUgZjYgNzQgN2UgOGIgNTUgZjAgOWMgOGYgMDIgZmEg
YmUgMDAgZTAgZmYgZmYgMjEgZTYgZmYgNDYgMTQgOGIgMTYgOGIgN2EgMjggPGZmPiAwZiA4YiA0
MiAyMCA4YiA0YSAyNCA4OSA0OCAwNCA4OSAwMSA4YiA1MiAxOCA4ZCA0NCBkNyAxOCAzOSAKCiAo
Z2RiKSBsaXN0ICp0cnlfdG9fd2FrZV91cCsweDFlMgogMHgyNmEgaXMgaW4gdHJ5X3RvX3dha2Vf
dXAgKGtlcm5lbC9zY2hlZC5jOjMxMCkuCiAzMDUgICAgIC8qCiAzMDYgICAgICAqIEFkZGluZy9y
ZW1vdmluZyBhIHRhc2sgdG8vZnJvbSBhIHByaW9yaXR5IGFycmF5OgogMzA3ICAgICAgKi8KIDMw
OCAgICAgc3RhdGljIGlubGluZSB2b2lkIGRlcXVldWVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnAsIHByaW9fYXJyYXlfdCAqYXJyYXkpCiAzMDkgICAgIHsKIDMxMCAgICAgICAgICAgICBhcnJh
eS0+bnJfYWN0aXZlLS07CiAzMTEgICAgICAgICAgICAgbGlzdF9kZWwoJnAtPnJ1bl9saXN0KTsK
IDMxMiAgICAgICAgICAgICBpZiAobGlzdF9lbXB0eShhcnJheS0+cXVldWUgKyBwLT5wcmlvKSkK
IDMxMyAgICAgICAgICAgICAgICAgICAgIF9fY2xlYXJfYml0KHAtPnByaW8sIGFycmF5LT5iaXRt
YXApOwogMzE0ICAgICB9CiAoZ2RiKQogPDY+bm90ZTogZ2NjWzU5Ml0gZXhpdGVkIHdpdGggcHJl
ZW1wdF9jb3VudCA1CmJhZDogc2NoZWR1bGluZyB3aGlsZSBhdG9taWMhCkNhbGwgVHJhY2U6CiBb
PGMwMTE1NGYwPl0gc2NoZWR1bGUrMHgzYy8weDM3OAogWzxjMDEzNGIyNj5dIHVubWFwX3ZtYXMr
MHhlYS8weDFlMAogWzxjMDExNjQ3Yj5dIF9fY29uZF9yZXNjaGVkKzB4MTcvMHgxYwogWzxjMDEz
NGI4Nj5dIHVubWFwX3ZtYXMrMHgxNGEvMHgxZTAKIFs8YzAxMzdmYjg+XSBleGl0X21tYXArMHg2
NC8weDE1OAogWzxjMDExNmRiZD5dIG1tcHV0KzB4NTUvMHg3NAogWzxjMDExYTM2OD5dIGRvX2V4
aXQrMHgxNTgvMHgzYjQKIFs8YzAxMDkyNjc+XSBkaWUrMHg4Ny8weDg4CiBbPGMwMTE0MDY4Pl0g
ZG9fcGFnZV9mYXVsdCsweDJkOC8weDQwNAogWzxjMDExM2Q5MD5dIGRvX3BhZ2VfZmF1bHQrMHgw
LzB4NDA0CiBbPGMwMTFiOTFhPl0gZG9fc29mdGlycSsweDVhLzB4YWMKIFs8YzAxMGExNzA+XSBk
b19JUlErMHhmYy8weDExOAogWzxjMDEyZTE3Mz5dIF9fcm1xdWV1ZSsweGEzLzB4MTBjCiBbPGMw
MTJlMjFmPl0gcm1xdWV1ZV9idWxrKzB4NDMvMHg2YwogWzxjMDEwOGQ2OT5dIGVycm9yX2NvZGUr
MHgyZC8weDM4CiBbPGMwMTE0ZDBhPl0gdHJ5X3RvX3dha2VfdXArMHgxZTIvMHgyNTgKIFs8YzAx
MTU4ODc+XSBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgxNy8weDFjCiBbPGMwMTE1OGMyPl0gX193
YWtlX3VwX2NvbW1vbisweDM2LzB4NTAKIFs8YzAxMTU5NGE+XSBfX3dha2VfdXBfbG9ja2VkKzB4
ZS8weDE0CiBbPGMwMTA3Y2RjPl0gX19kb3duX3RyeWxvY2srMHgzNC8weDU0CiBbPGMwMTA3ZDFi
Pl0gX19kb3duX2ZhaWxlZF90cnlsb2NrKzB4Ny8weGMKIFs8YzAxMTkyOGI+XSAudGV4dC5sb2Nr
LnByaW50aysweDUvMHgyYQogWzxjMDExNTVmMD5dIHNjaGVkdWxlKzB4MTNjLzB4Mzc4CiBbPGMw
MTFhYjA3Pl0gc3lzX3dhaXQ0KzB4YWIvMHgyMzQKIFs8YzAxMWFjNWQ+XSBzeXNfd2FpdDQrMHgy
MDEvMHgyMzQKIFs8YzAxMTU4NzA+XSBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgwLzB4MWMKIFs8
YzAxMTU4NzA+XSBkZWZhdWx0X3dha2VfZnVuY3Rpb24rMHgwLzB4MWMKIFs8YzAxMDhiNWY+XSBz
eXNjYWxsX2NhbGwrMHg3LzB4YgoKaG1tLi4gNDIgbXMKaG1tLi4gMjQgbXMKaG1tLi4gMzMgbXMK
aG1tLi4gMjMgbXMKaG1tLi4gMzEgbXMKaG1tLi4gMzAgbXMKaG1tLi4gMzAgbXMK
--=====================_47238343==_--

