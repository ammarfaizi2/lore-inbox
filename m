Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTH1RYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTH1RYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:24:20 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:41637
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263129AbTH1RYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:24:08 -0400
Message-ID: <3F4E3AA0.9030808@redhat.com>
Date: Thu, 28 Aug 2003 10:23:44 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: More ->pid to ->tgid changes
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010000040809020203080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010000040809020203080008
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

One more overlooked area where the thread group ID has to be used.
Compile and run the following code.  The program should always exit with
value zero, but currently it doesn't if a parameter is passed (i.e., if
the semaphore is modified in a thread other than the main one).  If
somebody wants to add the code to a kernel test suite, feel free.

The attached patch is against the current 2.5 tree.

#define _GNU_SOURCE
#include <errno.h>
#include <error.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sem.h>
#include <sys/wait.h>


union semun
{
  int val;
};

static int sem;

static void
eh (void)
{
  semctl (sem, 0, IPC_RMID);
}

static void
second_process (void)
{
  int val = semctl (sem, 0, GETPID);
  printf ("parent PID: %ld\nsem PID: %d\n", (long int) getppid (), val);
  exit (getppid () != val);
}

static void
setval (void)
{
  union semun su = { .val = 1 };
  if (semctl (sem, 0, SETVAL, su) == -1)
    error (EXIT_FAILURE, errno, "semctl failed");
}

static void *
tf (void *arg)
{
  setval ();
  return NULL;
}

int
main (int argc, char *argv[])
{
  sem = semget (IPC_PRIVATE, 1, IPC_CREAT | IPC_EXCL | 0666);
  if (sem == -1)
    error (EXIT_FAILURE, errno, "semget failed");

  atexit (eh);

  if (argc == 1)
    setval ();
  else
    {
      pthread_t th;
      int r = pthread_create (&th, NULL, tf, NULL);
      if (r != 0)
        error (EXIT_FAILURE, r, "pthread_create failed");
      r = pthread_join (th, NULL);
      if (r != 0)
        error (EXIT_FAILURE, r, "pthread_join failed");
    }

  pid_t pid = fork ();
  if (pid == -1)
    error (EXIT_FAILURE, errno, "fork failed");
  if (pid == 0)
    second_process ();

  int status;
  if (TEMP_FAILURE_RETRY (waitpid (pid, &status, 0)) != pid)
    error (EXIT_FAILURE, errno, "waitpid failed");

  if (!WIFEXITED (status))
    error (EXIT_FAILURE, 0, "child process didn't exit normally");

  return WEXITSTATUS (status);
}


- --
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Tjqg2ijCOnn/RHQRAs4KAJ9HlFJo3pfh/nChsLvldaDpk02KKwCeLXMz
kODgRkSVcOfNXs693xo1iK8=
=krhV
-----END PGP SIGNATURE-----

--------------010000040809020203080008
Content-Type: text/plain;
 name="d-ipc-pid"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-ipc-pid"

LS0tIGxpbnV4LTIuNS9pcGMvbXNnLmMtc2F2ZQkyMDAzLTA1LTE0IDAwOjM2OjI2LjAwMDAw
MDAwMCAtMDcwMAorKysgbGludXgtMi41L2lwYy9tc2cuYwkyMDAzLTA4LTI4IDEwOjA3OjUx
LjAwMDAwMDAwMCAtMDcwMApAQCAtNzA3LDcgKzcwNyw3IEBAIHJldHJ5OgogCQlnb3RvIHJl
dHJ5OwogCX0KIAotCW1zcS0+cV9sc3BpZCA9IGN1cnJlbnQtPnBpZDsKKwltc3EtPnFfbHNw
aWQgPSBjdXJyZW50LT50Z2lkOwogCW1zcS0+cV9zdGltZSA9IGdldF9zZWNvbmRzKCk7CiAK
IAlpZighcGlwZWxpbmVkX3NlbmQobXNxLG1zZykpIHsKQEAgLTgwMSw3ICs4MDEsNyBAQCBy
ZXRyeToKIAkJbGlzdF9kZWwoJm1zZy0+bV9saXN0KTsKIAkJbXNxLT5xX3FudW0tLTsKIAkJ
bXNxLT5xX3J0aW1lID0gZ2V0X3NlY29uZHMoKTsKLQkJbXNxLT5xX2xycGlkID0gY3VycmVu
dC0+cGlkOworCQltc3EtPnFfbHJwaWQgPSBjdXJyZW50LT50Z2lkOwogCQltc3EtPnFfY2J5
dGVzIC09IG1zZy0+bV90czsKIAkJYXRvbWljX3N1Yihtc2ctPm1fdHMsJm1zZ19ieXRlcyk7
CiAJCWF0b21pY19kZWMoJm1zZ19oZHJzKTsKLS0tIGxpbnV4LTIuNS9pcGMvc2VtLmMtc2F2
ZQkyMDAzLTA4LTE0IDAxOjI3OjAxLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi41L2lw
Yy9zZW0uYwkyMDAzLTA4LTI4IDEwOjA4OjA5LjAwMDAwMDAwMCAtMDcwMApAQCAtNjY0LDcg
KzY2NCw3IEBAIHN0YXRpYyBpbnQgc2VtY3RsX21haW4oaW50IHNlbWlkLCBpbnQgc2UKIAkJ
Zm9yICh1biA9IHNtYS0+dW5kbzsgdW47IHVuID0gdW4tPmlkX25leHQpCiAJCQl1bi0+c2Vt
YWRqW3NlbW51bV0gPSAwOwogCQljdXJyLT5zZW12YWwgPSB2YWw7Ci0JCWN1cnItPnNlbXBp
ZCA9IGN1cnJlbnQtPnBpZDsKKwkJY3Vyci0+c2VtcGlkID0gY3VycmVudC0+dGdpZDsKIAkJ
c21hLT5zZW1fY3RpbWUgPSBnZXRfc2Vjb25kcygpOwogCQkvKiBtYXliZSBzb21lIHF1ZXVl
ZC11cCBwcm9jZXNzZXMgd2VyZSB3YWl0aW5nIGZvciB0aGlzICovCiAJCXVwZGF0ZV9xdWV1
ZShzbWEpOwpAQCAtMTA1Miw3ICsxMDUyLDcgQEAgcmV0cnlfdW5kb3M6CiAJaWYgKGVycm9y
KQogCQlnb3RvIG91dF91bmxvY2tfZnJlZTsKIAotCWVycm9yID0gdHJ5X2F0b21pY19zZW1v
cCAoc21hLCBzb3BzLCBuc29wcywgdW4sIGN1cnJlbnQtPnBpZCk7CisJZXJyb3IgPSB0cnlf
YXRvbWljX3NlbW9wIChzbWEsIHNvcHMsIG5zb3BzLCB1biwgY3VycmVudC0+dGdpZCk7CiAJ
aWYgKGVycm9yIDw9IDApCiAJCWdvdG8gdXBkYXRlOwogCkBAIC0xMDY0LDcgKzEwNjQsNyBA
QCByZXRyeV91bmRvczoKIAlxdWV1ZS5zb3BzID0gc29wczsKIAlxdWV1ZS5uc29wcyA9IG5z
b3BzOwogCXF1ZXVlLnVuZG8gPSB1bjsKLQlxdWV1ZS5waWQgPSBjdXJyZW50LT5waWQ7CisJ
cXVldWUucGlkID0gY3VycmVudC0+dGdpZDsKIAlxdWV1ZS5pZCA9IHNlbWlkOwogCWlmIChh
bHRlcikKIAkJYXBwZW5kX3RvX3F1ZXVlKHNtYSAsJnF1ZXVlKTsKQEAgLTEyMDYsNyArMTIw
Niw3IEBAIGZvdW5kOgogCQkJCXNlbS0+c2VtdmFsICs9IHUtPnNlbWFkaltpXTsKIAkJCQlp
ZiAoc2VtLT5zZW12YWwgPCAwKQogCQkJCQlzZW0tPnNlbXZhbCA9IDA7IC8qIHNob3VsZG4n
dCBoYXBwZW4gKi8KLQkJCQlzZW0tPnNlbXBpZCA9IGN1cnJlbnQtPnBpZDsKKwkJCQlzZW0t
PnNlbXBpZCA9IGN1cnJlbnQtPnRnaWQ7CiAJCQl9CiAJCX0KIAkJc21hLT5zZW1fb3RpbWUg
PSBnZXRfc2Vjb25kcygpOwotLS0gbGludXgtMi41L2lwYy9zaG0uYy1zYXZlCTIwMDMtMDct
MTEgMjA6MzI6MTIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUvaXBjL3NobS5jCTIw
MDMtMDgtMjggMTA6MDg6MjIuMDAwMDAwMDAwIC0wNzAwCkBAIC04OSw3ICs4OSw3IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBzaG1faW5jIChpbnQgaWQpIHsKIAlpZighKHNocCA9IHNobV9s
b2NrKGlkKSkpCiAJCUJVRygpOwogCXNocC0+c2htX2F0aW0gPSBnZXRfc2Vjb25kcygpOwot
CXNocC0+c2htX2xwcmlkID0gY3VycmVudC0+cGlkOworCXNocC0+c2htX2xwcmlkID0gY3Vy
cmVudC0+dGdpZDsKIAlzaHAtPnNobV9uYXR0Y2grKzsKIAlzaG1fdW5sb2NrKHNocCk7CiB9
CkBAIC0xMzYsNyArMTM2LDcgQEAgc3RhdGljIHZvaWQgc2htX2Nsb3NlIChzdHJ1Y3Qgdm1f
YXJlYV9zdAogCS8qIHJlbW92ZSBmcm9tIHRoZSBsaXN0IG9mIGF0dGFjaGVzIG9mIHRoZSBz
aG0gc2VnbWVudCAqLwogCWlmKCEoc2hwID0gc2htX2xvY2soaWQpKSkKIAkJQlVHKCk7Ci0J
c2hwLT5zaG1fbHByaWQgPSBjdXJyZW50LT5waWQ7CisJc2hwLT5zaG1fbHByaWQgPSBjdXJy
ZW50LT50Z2lkOwogCXNocC0+c2htX2R0aW0gPSBnZXRfc2Vjb25kcygpOwogCXNocC0+c2ht
X25hdHRjaC0tOwogCWlmKHNocC0+c2htX25hdHRjaCA9PSAwICYmCkBAIC0yMDksNyArMjA5
LDcgQEAgc3RhdGljIGludCBuZXdzZWcgKGtleV90IGtleSwgaW50IHNobWZsZwogCWlmKGlk
ID09IC0xKSAKIAkJZ290byBub19pZDsKIAotCXNocC0+c2htX2NwcmlkID0gY3VycmVudC0+
cGlkOworCXNocC0+c2htX2NwcmlkID0gY3VycmVudC0+dGdpZDsKIAlzaHAtPnNobV9scHJp
ZCA9IDA7CiAJc2hwLT5zaG1fYXRpbSA9IHNocC0+c2htX2R0aW0gPSAwOwogCXNocC0+c2ht
X2N0aW0gPSBnZXRfc2Vjb25kcygpOwo=
--------------010000040809020203080008--

