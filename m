Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287371AbSALTZj>; Sat, 12 Jan 2002 14:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSALTZV>; Sat, 12 Jan 2002 14:25:21 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17638 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287342AbSALTZB>;
	Sat, 12 Jan 2002 14:25:01 -0500
Date: Sat, 12 Jan 2002 11:07:16 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: BIO Usage Error or Conflicting Designs
In-Reply-To: <200201121828.g0CISaM342258@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.10.10201121040040.13034-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/MIXED; BOUNDARY="1430322656-707232361-1010862074=:13034"
Content-ID: <Pine.LNX.4.10.10201121101300.13034@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-707232361-1010862074=:13034
Content-Type: text/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.4.10.10201121101301.13034@master.linux-ide.org>


Jens,

Below is a single sector read using ACB.
If I do not use the code inside "#ifdef USEBIO" and run UP/SMP but no
highmem, it runs and works like a charm.  It is also 100% unchanged code
from what is in 2.4 patches.  The attached oops is generate under
SMP without highmem and running the USEBIO code.

CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


/*
 * Handler for command with PIO data-in phase
 */
ide_startstop_t task_in_intr (ide_drive_t *drive)
{
  byte stat               = GET_STAT();
  byte io_32bit           = drive->io_32bit;
  struct request *rq      = HWGROUP(drive)->rq;
  char *pBuf              = NULL;

  if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
    if (stat & (ERR_STAT|DRQ_STAT)) {
      return ide_error(drive, "task_in_intr", stat);
    }
    if (!(stat & BUSY_STAT)) {
      DTF("task_in_intr to Soon wait for next interrupt\n");
      ide_set_handler(drive, &task_in_intr, WAIT_CMD, NULL);
      return ide_started;
    }
  }
  drive->io_32bit = 0;
  DTF("stat: %02x\n", stat);
#ifdef USEBIO
  if (rq->flags & REQ_CMD) {
    pBuf = ide_map_buffer(rq, &flags);
  } else {
    pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
  }
#else
  pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
#endif
  DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
  taskfile_input_data(drive, pBuf, SECTOR_WORDS);
#ifdef USEBIO
  if (rq->flags & REQ_CMD)
    ide_unmap_buffer(pBuf, &flags);
  rq->sector++;
  rq->errors = 0;
#endif
  drive->io_32bit = io_32bit;
  if (--rq->current_nr_sectors <= 0) {
    /* (hs): swapped next 2 lines */
    DTF("Request Ended stat: %02x\n", GET_STAT());
    ide_end_request(1, HWGROUP(drive));
  } else {
    ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
    return ide_started;
  }
  return ide_stopped;
}


--1430322656-707232361-1010862074=:13034
Content-Type: text/PLAIN; CHARSET=us-ascii; NAME="bio.oops.file"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10201121101140.13034@master.linux-ide.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="bio.oops.file"

a3N5bW9vcHMgMi4zLjUgb24gaTY4NiAyLjUuMi1wcmUxMS4gIE9wdGlvbnMg
dXNlZA0KICAgICAtViAoZGVmYXVsdCkNCiAgICAgLWsgL3Byb2Mva3N5bXMg
KGRlZmF1bHQpDQogICAgIC1sIC9wcm9jL21vZHVsZXMgKGRlZmF1bHQpDQog
ICAgIC1vIC9saWIvbW9kdWxlcy8yLjUuMi1wcmUxMS8gKGRlZmF1bHQpDQog
ICAgIC1tIC91c3Ivc3JjL2xpbnV4L1N5c3RlbS5tYXAgKHNwZWNpZmllZCkN
Cg0KTm8gbW9kdWxlcyBpbiBrc3ltcywgc2tpcHBpbmcgb2JqZWN0cw0KV2Fy
bmluZyAocmVhZF9sc21vZCk6IG5vIHN5bWJvbHMgaW4gbHNtb2QsIGlzIC9w
cm9jL21vZHVsZXMgYSB2YWxpZCBsc21vZCBmaWxlPw0KY3B1OiAwLCBjbG9j
a3M6IDI2NTk4NDksIHNsaWNlOiA4ODY2MTYNCmNwdTogMSwgY2xvY2tzOiAy
NjU5ODQ5LCBzbGljZTogODg2NjE2DQppbnZhbGlkIG9wZXJhbmQ6IDAwMDAN
CkNQVTogICAgMA0KRUlQOiAgICAwMDEwOls8YzAxMzZkZDk+XSAgICBOb3Qg
dGFpbnRlZA0KVXNpbmcgZGVmYXVsdHMgZnJvbSBrc3ltb29wcyAtdCBlbGYz
Mi1pMzg2IC1hIGkzODYNCkVGTEFHUzogMDAwMTAyODMNCmVheDogMDAwMzgw
MDAgICBlYng6IDAwMDAwMDcwICAgZWN4OiBmNzBlNDk4MCAgIGVkeDogZjcw
ZTQ5ODANCmVzaTogYzA0MDIwODQgICBlZGk6IDAwMDM4MDAwICAgZWJwOiBm
NzBlNDk4MCAgIGVzcDogZjZhMDFkZjQNCmRzOiAwMDE4ICAgZXM6IDAwMTgg
ICBzczogMDAxOA0KUHJvY2VzcyBoZHBhcm0gKHBpZDogODIyLCBzdGFja3Bh
Z2U9ZjZhMDEwMDApDQpTdGFjazogMDAwMDAwMDAgYzA0MDIwODQgMDAwMDAw
MDIgZjcwZTQ5ODAgMDAwMDEwMDAgMDAwMDAwMDEgMDAwMDAwMDAgMDAwMDAy
MTcgDQogICAgICAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgYzAxZmNhZmUgMDAwMzgwMDAgMDAwMDAwNzAgZjZhMDFlNjggDQogICAg
ICAgMDAwMDAwMDAgZjdkMTA2NDAgYzA0MDIwODQgZjcwZTQ5ODAgMDAwMDAw
MDIgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDIgDQpDYWxsIFRyYWNlOiBb
PGMwMWZjYWZlPl0gWzxjMDFmZDAzNj5dIFs8YzAxZmQxNGM+XSBbPGMwMWZk
MWY5Pl0gWzxjMDEzYmUzYj5dIA0KICAgWzxjMDEzZjAwZj5dIFs8YzAxM2Vm
NzA+XSBbPGMwMTJiN2NlPl0gWzxjMDEyYmM4Mj5dIFs8YzAxMmJiOTA+XSBb
PGMwMTM5MGNlPl0gDQogICBbPGMwMTA4YzdmPl0gDQpDb2RlOiAwZiAwYiBj
NyA0NCAyNCAyNCA3MCAwMCAwMCAwMCA4YiAxZCA2OCAwOCAzZSBjMCA4OSA1
YyAyNCAyMCANCg0KPj5FSVA7IGMwMTM2ZGQ5IDxjcmVhdGVfYm91bmNlKzQ5
LzJjMD4gICA8PT09PT0NClRyYWNlOyBjMDFmY2FmZSA8X19tYWtlX3JlcXVl
c3QrNWUvNDcwPg0KVHJhY2U7IGMwMWZkMDM2IDxnZW5lcmljX21ha2VfcmVx
dWVzdCsxMjYvMWIwPg0KVHJhY2U7IGMwMWZkMTRjIDxzdWJtaXRfYmlvKzRj
LzYwPg0KVHJhY2U7IGMwMWZkMWY5IDxzdWJtaXRfYmgrOTkvYTA+DQpUcmFj
ZTsgYzAxM2JlM2IgPGJsb2NrX3JlYWRfZnVsbF9wYWdlKzFkYi8xZjA+DQpU
cmFjZTsgYzAxM2YwMGYgPGJsa2Rldl9yZWFkcGFnZStmLzIwPg0KVHJhY2U7
IGMwMTNlZjcwIDxibGtkZXZfZ2V0X2Jsb2NrKzAvNDA+DQpUcmFjZTsgYzAx
MmI3Y2UgPGRvX2dlbmVyaWNfZmlsZV9yZWFkKzJkZS80NjA+DQpUcmFjZTsg
YzAxMmJjODIgPGdlbmVyaWNfZmlsZV9yZWFkKzkyLzE5MD4NClRyYWNlOyBj
MDEyYmI5MCA8ZmlsZV9yZWFkX2FjdG9yKzAvNjA+DQpUcmFjZTsgYzAxMzkw
Y2UgPHN5c19yZWFkKzhlL2QwPg0KVHJhY2U7IGMwMTA4YzdmIDxzeXN0ZW1f
Y2FsbCszMy8zOD4NCkNvZGU7ICBjMDEzNmRkOSA8Y3JlYXRlX2JvdW5jZSs0
OS8yYzA+DQowMDAwMDAwMCA8X0VJUD46DQpDb2RlOyAgYzAxMzZkZDkgPGNy
ZWF0ZV9ib3VuY2UrNDkvMmMwPiAgIDw9PT09PQ0KICAgMDogICAwZiAwYiAg
ICAgICAgICAgICAgICAgICAgIHVkMmEgICAgICA8PT09PT0NCkNvZGU7ICBj
MDEzNmRkYiA8Y3JlYXRlX2JvdW5jZSs0Yi8yYzA+DQogICAyOiAgIGM3IDQ0
IDI0IDI0IDcwIDAwIDAwICAgICAgbW92bCAgICQweDcwLDB4MjQoJWVzcCwx
KQ0KQ29kZTsgIGMwMTM2ZGUyIDxjcmVhdGVfYm91bmNlKzUyLzJjMD4NCiAg
IDk6ICAgMDAgDQpDb2RlOyAgYzAxMzZkZTMgPGNyZWF0ZV9ib3VuY2UrNTMv
MmMwPg0KICAgYTogICA4YiAxZCA2OCAwOCAzZSBjMCAgICAgICAgIG1vdiAg
ICAweGMwM2UwODY4LCVlYngNCkNvZGU7ICBjMDEzNmRlOSA8Y3JlYXRlX2Jv
dW5jZSs1OS8yYzA+DQogIDEwOiAgIDg5IDVjIDI0IDIwICAgICAgICAgICAg
ICAgbW92ICAgICVlYngsMHgyMCglZXNwLDEpDQoNCg0KMSB3YXJuaW5nIGlz
c3VlZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxpYWJsZS4NCg==
--1430322656-707232361-1010862074=:13034--
