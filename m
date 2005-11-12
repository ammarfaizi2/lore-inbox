Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVKLH7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVKLH7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 02:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVKLH7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 02:59:25 -0500
Received: from mailspool.ops.uunet.co.za ([196.7.0.140]:17417 "EHLO
	mailspool.ops.uunet.co.za") by vger.kernel.org with ESMTP
	id S932192AbVKLH7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 02:59:24 -0500
Message-ID: <4375A0D7.5070502@kroon.co.za>
Date: Sat, 12 Nov 2005 09:59:19 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051007
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: netfilter netbios-ns on ethernet bridge firewall
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060908060009090408020809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060908060009090408020809
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

I'm trying to make the ip_conntrack_netbios_ns module work on my
ethernet bridge firewall.  The module works extremely nicely on a single
host when packets are locally generated, but doesn't even look at the
packets if they are generated elsewhere and merely pass through our box.

I'm currently running a vanilla kernel (2.6.14) with some of my own
printk statements and some minor modifications (diff below).

My configuration is essentially a device called br0 with eth0 and eth1
as it's two physical interfaces.  I've got an IP of 192.168.0.4 assigned
to br0 (and an alias of 192.168.2.2), neither eth0 nor eth1 has an IP.

With the patch below applied when I send out a netbios-ns packet from
192.168.0.3 (coming in off eth0) I get the following in my logs:

Nov 12 09:38:17 xacatecas netbios packet seen
Nov 12 09:38:17 xacatecas sk is null
Nov 12 09:38:17 xacatecas rtable dst: 00000000
Nov 12 09:38:17 xacatecas rtable src: 00000000
Nov 12 09:38:17 xacatecas rtable iif: 00000000
Nov 12 09:38:17 xacatecas netbios packet seen
Nov 12 09:38:17 xacatecas sk is null
Nov 12 09:38:17 xacatecas rtable dst: ff00a8c0
Nov 12 09:38:17 xacatecas rtable src: 0300a8c0
Nov 12 09:38:17 xacatecas rtable iif: 00000004
Nov 12 09:38:17 xacatecas is a broadcast
Nov 12 09:38:17 xacatecas packet accepted!
Nov 12 09:38:17 xacatecas checking ...
Nov 12 09:38:17 xacatecas (lo) 00000000 vs ff00a8c0
Nov 12 09:38:17 xacatecas You almost certainly have a misconfigured
broadcast address.

>From what I understand the packet passes through the conntrack module
twice, once on PREROUTING and once on POSTROUTING, which is why the
first instance has rtable all zeroed.  The second time round I expect to
see br0s details in the rtable, not lo though!  The routing table looks
as follows:

Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
192.168.2.0     0.0.0.0         255.255.255.0   U         0 0          0 br0
192.168.0.0     0.0.0.0         255.255.255.0   U         0 0          0 br0
127.0.0.0       127.0.0.1       255.0.0.0       UG        0 0          0 lo
0.0.0.0         192.168.0.1     0.0.0.0         UG        0 0          0 br0


In essense I've got two choices now:

1.  Hardcode the mask as in the commented out mask = 0x00FFFFFF below,
which will only work for myself.  (Or pass it as a parameter or
something - what happens in cases where the netmasks differ for multiple
interfaces?)

2.  Cycle through the devices as provided by rtable, but also cycle
through _all_ inet devices.  This would be more generic, but somehow I
don't think this is the correct solution, and it would eat a lot more CPU.

Thanks for any and all help/advice.

Jaco


--- net/ipv4/netfilter/ip_conntrack_netbios_ns.c.orig   2005-11-12
09:39:35.000000000 +0200
+++ net/ipv4/netfilter/ip_conntrack_netbios_ns.c        2005-11-12
09:33:18.000000000 +0200
@@ -50,32 +50,52 @@
        u_int32_t mask = 0;

        /* we're only interested in locally generated packets */
+       printk("netbios packet seen\n");
        if ((*pskb)->sk == NULL)
-               goto out;
+               printk("sk is null\n");
+       if (rt == NULL)
+               printk("rt == NULL!\n");
+       else {
+               printk("rtable dst: %08x\n", rt->rt_dst);
+               printk("rtable src: %08x\n", rt->rt_src);
+               printk("rtable iif: %08x\n", rt->rt_iif);
+       }
        if (rt == NULL || !(rt->rt_flags & RTCF_BROADCAST))
                goto out;
+       printk("is a broadcast\n");
        if (CTINFO2DIR(ctinfo) != IP_CT_DIR_ORIGINAL)
                goto out;
-
+       printk("packet accepted!\n");
+
+//     mask = 0x00FFFFFF;
        rcu_read_lock();
        in_dev = __in_dev_get_rcu(rt->u.dst.dev);
        if (in_dev != NULL) {
+               printk("checking ...\n");
                for_primary_ifa(in_dev) {
+                       printk("(%s) %08x vs %08x\n", ifa->ifa_label,
ifa->ifa_broadcast, iph->daddr);
                        if (ifa->ifa_broadcast == iph->daddr) {
                                mask = ifa->ifa_mask;
-                               break;
+                               printk(":)\n");
+//                             break;
                        }
                } endfor_ifa(in_dev);
        }
        rcu_read_unlock();

-       if (mask == 0)
+       if (mask == 0) {
+               printk(KERN_INFO "You almost certainly have a
misconfigured broadcast address.\n");
                goto out;
+       }

+       printk("Yes, we are delivering to a local broadcast addr!\n");
+
        exp = ip_conntrack_expect_alloc(ct);
        if (exp == NULL)
                goto out;

+       printk("We have managed to allocate an expect structure,
proceeding to add expect.\n");
+
        exp->tuple                = ct->tuplehash[IP_CT_DIR_REPLY].tuple;
        exp->tuple.src.u.udp.port = ntohs(NMBD_PORT);

-- 
There are only 10 kinds of people in this world,
  those that understand binary and those that don't.
http://www.kroon.co.za/

--------------ms060908060009090408020809
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII5TCC
As0wggI2oAMCAQICAw3p1jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI4MjExMjIzWhcNMDYwMTI4MjExMjIz
WjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZIhvcNAQkBFhBq
YWNvQGtyb29uLmNvLnphMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4CsLuOWD
wimwAv4QLdlT99frJCwzUBVQNL7c7x4ufEquAH6RamWfQyQHzykEJM8NeMIrfb+k3fZEi+ZU
g5sq2uIqzOuCJsIj0x3LnoydXTikbv1AFWQDEuqITlroA8bGJE/mMlbPrKyDACPo5cQAzUQz
LAg7LQQQVkKNWH4eeXUwZ5lOZEWWno0P5DXHdSLQxCshgWVPRrbtKe25WGObqJMa//1T5qX8
0mKIdAbHlz90BwgX/MjLp0BpXTii2653ScOujCLTC3cPdDUDK68qG7RqatVw5+HE/npJIWa1
0TxJUp5Ii8nPbGPzpEWQmZ8TjkjMs26w80PPPKh2Vh2siQIDAQABoy0wKzAbBgNVHREEFDAS
gRBqYWNvQGtyb29uLmNvLnphMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAqXNX
QEMTVQoj3JoEwK9vlfqSVz5ZEUklpgEhwFJsD+PKa/LgUGVHk3Gw8wws4+wZxmpOsJ7vdiWL
y8zlX7HfPWMcbibTi6C7nT6WahqdeAo3kVjhnMqJ3Sf6sX0JGl9bWfIhgmIVy/ZdM2ztrXwd
rbWiT7un5lM05D4YPCNH9fcwggLNMIICNqADAgECAgMN6dYwDQYJKoZIhvcNAQEEBQAwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MDEyODIx
MTIyM1oXDTA2MDEyODIxMTIyM1owQjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJl
cjEfMB0GCSqGSIb3DQEJARYQamFjb0Brcm9vbi5jby56YTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAOArC7jlg8IpsAL+EC3ZU/fX6yQsM1AVUDS+3O8eLnxKrgB+kWpln0Mk
B88pBCTPDXjCK32/pN32RIvmVIObKtriKszrgibCI9Mdy56MnV04pG79QBVkAxLqiE5a6APG
xiRP5jJWz6ysgwAj6OXEAM1EMywIOy0EEFZCjVh+Hnl1MGeZTmRFlp6ND+Q1x3Ui0MQrIYFl
T0a27SntuVhjm6iTGv/9U+al/NJiiHQGx5c/dAcIF/zIy6dAaV04otuud0nDrowi0wt3D3Q1
AyuvKhu0amrVcOfhxP56SSFmtdE8SVKeSIvJz2xj86RFkJmfE45IzLNusPNDzzyodlYdrIkC
AwEAAaMtMCswGwYDVR0RBBQwEoEQamFjb0Brcm9vbi5jby56YTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAKlzV0BDE1UKI9yaBMCvb5X6klc+WRFJJaYBIcBSbA/jymvy4FBl
R5NxsPMMLOPsGcZqTrCe73Yli8vM5V+x3z1jHG4m04ugu50+lmoanXgKN5FY4ZzKid0n+rF9
CRpfW1nyIYJiFcv2XTNs7a18Ha21ok+7p+ZTNOQ+GDwjR/X3MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCAzswggM3AgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAgMN6dYwCQYFKw4DAhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUxMTEyMDc1OTE5WjAjBgkqhkiG9w0BCQQxFgQURLGV
o8i/W1V1DT2NS006NadgcFAwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYB
BAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0ECAw3p1jB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMN6dYwDQYJKoZIhvcNAQEBBQAEggEAUu45ATT9Km3D+zaT
Rscb+/xneb8hxA3BnpN7ORii/Kwu9xyAkLZw1YXecBCMr4du3xp/v8mzEfB5mqHZpA73GSm3
TARlEWvshm193O08GaHVOqywbxV8uf/uZdenJRCN5Qvi16VQP9VPmYRhTCYXzQFWblMB3oGh
154T54EXItlGYPPUe0bddddqiNTM9lprC84F/xLDdH4LNkAGEYGZJX63Yh3XzegO0jD6QhuQ
EjJQQtbHNZCTXpEsMBxUtE8gwM1k7GcMLdqiuULry0S1uzFZy25UUvbmZqEt4ydKMCfM3XiG
540gMhk3crR0m73yTBKzv0oG6D9dDuVdrGRQWwAAAAAAAA==
--------------ms060908060009090408020809--
